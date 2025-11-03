/* eslint-disable no-unused-vars */
import React from "react";
import axios from "axios";
import modules, { excludeFields } from "../js/config/modules.js";
import { getLabelByItem } from "./modulesDataUtils.js";

/* ============================================================
 * 🔧 Funções utilitárias gerais
 * ============================================================ */

/**
 * Retorna inteiro aleatório até o valor máximo.
 * @param {number} max
 * @returns {number}
 */
export function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

/**
 * Retorna número binário aleatório até o valor máximo.
 * @param {number} max
 * @returns {string}
 */
export function getRandomBin(max) {
  return Math.floor(Math.random() * max).toString(2);
}

/**
 * Retorna número hexadecimal aleatório até o valor máximo.
 * @param {number} max
 * @returns {string}
 */
export function getRandomHex(max) {
  return Math.floor(Math.random() * max).toString(16);
}

/**
 * Formata segundos no formato MM:SS.
 * @param {number} timeinSeconds
 * @returns {string}
 */
export function formatTime(timeinSeconds) {
  const minutes = Math.floor(timeinSeconds / 60)
    .toString()
    .padStart(2, "0");
  const seconds = Math.floor(timeinSeconds - minutes * 60)
    .toString()
    .padStart(2, "0");
  return `${minutes}:${seconds}`;
}

/**
 * Converte tempo no formato MM:SS para segundos.
 * @param {string} timeString
 * @returns {number}
 */
export function formatTimeInSeconds(timeString) {
  const [minutes, seconds] = timeString.split(":").map(Number);
  return seconds + minutes * 60;
}

/**
 * Envia erro de telemetria.
 * @param {Error|string} error
 */
export async function onErrorTelemetria(error) {
  console.error("Erro detectado: ", error);
  try {
    await axios.post(`${url}/telemetria`, "Erro detectado: " + error);
  } catch (e) {
    console.error(e);
  }
}

/**
 * Extrai chaves de um objeto ou array.
 * @param {Object|Array} input
 * @returns {string[]}
 */
export function extractKeys(input) {
  if (Array.isArray(input)) {
    if (input.length > 0 && typeof input[0] === "object" && input[0] !== null) {
      return Object.keys(input[0]);
    }
  } else if (typeof input === "object" && input !== null) {
    if (Array.isArray(input.newPageFields)) return input.newPageFields;
    if (Array.isArray(input.data) && input.data.length > 0)
      return Object.keys(input.data[0]);
    return Object.keys(input);
  }
  console.warn("[extractKeys] Formato inesperado:", input);
  return [];
}

/**
 * Filtra campos de acordo com filtros fornecidos.
 * @param {string[]} filtros
 * @param {object[]|object|string[]} dados
 * @returns {object[]|object|string[]}
 */
export function filtrarCampos(filtros, dados) {
  if (Array.isArray(dados) && typeof dados[0] === "string") {
    return dados.filter((campo) => !filtros.includes(campo));
  }
  if (Array.isArray(dados) && typeof dados[0] === "object") {
    return dados.map((item) =>
      Object.fromEntries(
        Object.entries(item).filter(([chave]) => !filtros.includes(chave))
      )
    );
  }
  if (typeof dados === "object" && dados !== null) {
    return Object.fromEntries(
      Object.entries(dados).filter(([chave]) => !filtros.includes(chave))
    );
  }
  console.warn("[filtrarCampos] Tipo inesperado:", dados);
  return dados;
}

/* ============================================================
 * 🧩 Sistema de geração de campos de formulário
 * ============================================================ */

function isDateString(value) {
  return typeof value === "string" && /^(\d{2}[\/-]\d{2}[\/-]\d{4})$/.test(value);
}

function isPasswordField(key) {
  return key.toLowerCase().includes("senha");
}

export function getFieldType(value, key) {
  if (Array.isArray(value)) return { type: "select", options: value };
  if (typeof value === "boolean") return { type: "checkbox", options: null };
  if (typeof value === "number") return { type: "number", options: null };
  if (isPasswordField(key)) return { type: "password", options: null };
  if (isDateString(value)) {
    const [d, m, y] = value.split(/[\/-]/);
    return { type: "date", options: null, defaultValue: `${y}-${m}-${d}` };
  }
  return { type: "text", options: null };
}

function formatLabel(key) {
  return key.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase());
}

function getOptionsFromModules(fieldName) {
  const mod = modules.find((m) =>
    m.name.toLowerCase().includes(fieldName.toLowerCase())
  );
  if (!mod || !Array.isArray(mod.data)) return [];
  return mod.data.map(
    (item) => item.nome || item.titulo || item.name || item.id || "Desconhecido"
  );
}

/**
 * Gera os campos do formulário automaticamente com base na estrutura de um objeto exemplo.
 * @param {Object} obj - Objeto exemplo.
 * @returns {Array<{ name: string, label: string, type: string, options: any[] | null }>}
 */
export function generateFormFields(obj) {
  return Object.keys(obj)
    .filter((key) => !excludeFields.includes(key))
    .map((key) => {
      const value = obj[key];
      let type = "text";
      let options = null;

      // 🔹 Se for um array de strings → select
      if (Array.isArray(value) && value.every((v) => typeof v === "string")) {
        type = "select";
        options = value;
      }

      // 🔹 Se for array de números → select também (ou select múltiplo se quiser)
      else if (Array.isArray(value) && value.every((v) => typeof v === "number")) {
        type = "select";
        options = value;
      }

      // 🔹 Se for booleano → checkbox
      else if (typeof value === "boolean") {
        type = "checkbox";
      }

      // 🔹 Se for número → number
      else if (typeof value === "number") {
        type = "number";
      }

      // 🔹 Se o nome do campo contiver "senha" → password
      else if (key.toLowerCase().includes("senha")) {
        type = "password";
      }

      // 🔹 Se for data no formato dd/mm/yyyy ou yyyy-mm-dd → date
      else if (
        typeof value === "string" &&
        /^(\d{4}-\d{2}-\d{2}|\d{2}[\/-]\d{2}[\/-]\d{4})$/.test(value)
      ) {
        type = "date";
      }

      // 🔹 Se o nome termina em "id" → select baseado em outro módulo
      else if (key.toLowerCase().endsWith("id")) {
        type = "select";
        options = getOptionsFromModules(key);
      }

      return {
        name: key,
        label: getLabelByItem(key),
        type,
        options,
      };
    });
}
