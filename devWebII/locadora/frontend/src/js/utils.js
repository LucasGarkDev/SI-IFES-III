/* eslint-disable no-unused-vars */
import React from "react";
import axios from "axios";
import modules, { excludeFields } from "../js/config/modules.js";
import { getModuleData, getModuleSchema } from "./modulesUtils.js";

/* ============================================================
 * 🔧 Funções utilitárias gerais
 * ============================================================ */

/**
 * Retorna um item de um array pelo ID.
 * @param {string|number} id - ID a ser buscado.
 * @param {Array<Object>} array - Array de objetos.
 * @returns {Object|undefined} Item encontrado.
 */
export const getItemFromId = (id, array) =>
  array.find((item) => item.id === Number(id));

/**
 * Retorna inteiro aleatório até o valor máximo.
 * @param {number} max
 * @returns {number}
 */
export const getRandomInt = (max) => Math.floor(Math.random() * max);

/**
 * Retorna número binário aleatório até o valor máximo.
 * @param {number} max
 * @returns {string}
 */
export const getRandomBin = (max) => Math.floor(Math.random() * max).toString(2);

/**
 * Retorna número hexadecimal aleatório até o valor máximo.
 * @param {number} max
 * @returns {string}
 */
export const getRandomHex = (max) => Math.floor(Math.random() * max).toString(16);

/**
 * Formata segundos no formato MM:SS.
 * @param {number} timeinSeconds
 * @returns {string}
 */
export const formatTime = (timeinSeconds) => {
  const minutes = Math.floor(timeinSeconds / 60).toString().padStart(2, "0");
  const seconds = Math.floor(timeinSeconds % 60).toString().padStart(2, "0");
  return `${minutes}:${seconds}`;
};

/**
 * Converte tempo no formato MM:SS para segundos.
 * @param {string} timeString
 * @returns {number}
 */
export const formatTimeInSeconds = (timeString) => {
  const [minutes, seconds] = timeString.split(":").map(Number);
  return minutes * 60 + seconds;
};

/**
 * Envia erro de telemetria.
 * @param {Error|string} error
 */
export const onErrorTelemetria = async (error) => {
  console.error("Erro detectado: ", error);
  try {
    await axios.post(`${url}/telemetria`, "Erro detectado: " + error);
  } catch (e) {
    console.error(e);
  }
};

/* ============================================================
 * 🧩 Sistema de geração de campos de formulário
 * ============================================================ */

/**
 * Detecta se o valor é uma data no formato DD/MM/YYYY ou DD-MM-YYYY
 * @param {string} value
 * @returns {boolean}
 */
const isDateString = (value) =>
  typeof value === "string" && /^(\d{2}[\/-]\d{2}[\/-]\d{4})$/.test(value);

/**
 * Detecta se o campo parece senha
 * @param {string} key
 * @returns {boolean}
 */
const isPasswordField = (key) => key.toLowerCase().includes("senha");

/**
 * Define tipo de campo e opções baseado no valor e nome
 * @param {*} value
 * @param {string} key
 * @returns {{ type: string, options: Array|null }}
 */
export const getFieldType = (value, key) => {
  if (Array.isArray(value)) return { type: "select", options: value };
  if (typeof value === "boolean") return { type: "checkbox", options: null };
  if (typeof value === "number") return { type: "number", options: null };
  if (isPasswordField(key)) return { type: "password", options: null };
  if (isDateString(value)) {
    const [d, m, y] = value.split(/[\/-]/);
    return { type: "date", options: null, defaultValue: `${y}-${m}-${d}` };
  }
  return { type: "text", options: null };
};

/**
 * Converte chave em rótulo legível
 * @param {string} key
 * @returns {string}
 */
const formatLabel = (key) => key.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase());

/**
 * Gera campos de formulário a partir de objeto
 * @param {Object} obj
 * @returns {Array<{ name: string, label: string, type: string, options: Array|null }>}
 */
export const generateFormFields = (obj) =>
  Object.keys(obj)
    .filter((key) => !excludeFields.includes(key))
    .map((key) => {
      let type = "text";
      let options = null;

      if (key.toLowerCase().endsWith("id")) {
        type = "select";
        options = getOptionsFromModules(key);
      }

      if (Array.isArray(obj[key]) && obj[key].length === 1 && typeof obj[key][0] === "number") {
        type = "select-multiple";
        options = getOptionsFromModules(key);
      }

      return {
        name: key,
        label: formatLabel(key),
        type,
        options,
      };
    });

/* ============================================================
 * 🧩 Getters dinâmicos para cada campo do databaseSchema
 * ============================================================ */

/**
 * Cria getters dinâmicos baseados no schema de cada módulo
 * @param {Array<Object>} array
 * @param {string} field
 * @returns {Function} Função de filtro
 */
export const createGetter = (array, field) => (value) =>
  array.filter((item) => {
    if (!item[field]) return false;
    if (Array.isArray(item[field])) {
      if (typeof item[field][0] === "object") {
        // Array de objetos (ex: dependentes)
        return item[field].some((el) =>
          Object.values(el).some((v) => typeof v === "string" && v.toLowerCase() === value.toLowerCase())
        );
      }
      // Array de valores simples (ex: atoresIds)
      return item[field].includes(value);
    }
    if (typeof item[field] === "string") return item[field].toLowerCase() === value.toLowerCase();
    return item[field] === value;
  });

/**
 * Gera todos os getters para um módulo
 * @param {string} moduleName
 * @returns {Object<string, Function>} Objeto com funções getter por campo
 */
export const generateModuleGetters = (moduleName) => {
  const schema = getModuleSchema(moduleName);
  const data = getModuleData(moduleName) || [];
  if (!schema) return {};

  const getters = {};
  Object.keys(schema).forEach((field) => {
    getters[`getBy${field[0].toUpperCase() + field.slice(1)}`] = createGetter(data, field);
  });
  return getters;
};