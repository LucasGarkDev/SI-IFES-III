/* eslint-disable no-unused-vars */
import React from "react";
import axios from "axios";
import modules from "../js/config/modules.js";

/* ============================================================
 * 🔧 Funções utilitárias gerais
 * ============================================================ */

/**
 * Retorna um item de um array pelo ID.
 * @param {string|number} id - ID a ser buscado.
 * @param {Array<Object>} array - Array de objetos.
 * @returns {Object|undefined} Item encontrado.
 */
export function getItemFromId(id, array) {
  const foundItem = array.find((item) => getIDtem(item) === Number(id));
  return foundItem;
}

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
 * Busca módulo pelo nome.
 * @param {string} moduleName
 * @returns {Object|undefined}
 */
export function findModuleConfig(moduleName) {
  return modules.find((mod) => mod.name === moduleName);
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
 * Retorna título genérico de item.
 * @param {Object} selectedItem
 * @returns {string}
 */
export function getTitleItem(selectedItem) {
  if (!selectedItem) return "[getTitleItem] NO ITEM PROVIDED";
  return (
    selectedItem.nome ||
    selectedItem.name ||
    selectedItem.titulo ||
    selectedItem.title ||
    selectedItem.id ||
    selectedItem._id ||
    "Item Selecionado"
  );
}

/**
 * Retorna ID de item.
 * @param {Object} selectedItem
 * @returns {string|number|null}
 */
export function getIDtem(selectedItem) {
  if (!selectedItem) return "[getIDtem] NO ITEM PROVIDED";
  return selectedItem._id || selectedItem.id || null;
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

/**
 * Verifica se o campo parece ser uma data no formato DD/MM/YYYY.
 * @param {string} value
 * @returns {boolean}
 */
function isDateString(value) {
  return typeof value === "string" && /^\d{2}\/\d{2}\/\d{4}$/.test(value);
}

/**
 * Verifica se o nome do campo indica senha.
 * @param {string} key
 * @returns {boolean}
 */
function isPasswordField(key) {
  return key.toLowerCase().includes("senha");
}

/**
 * Define o tipo de campo e opções baseado em seu valor e nome.
 * @param {*} value
 * @param {string} key
 * @returns {{ type: string, options: Array|null }}
 */
export function getFieldType(value, key) {
  if (Array.isArray(value)) return { type: "select", options: value };
  if (typeof value === "boolean") return { type: "checkbox", options: null };
  if (typeof value === "number") return { type: "number", options: null };
  if (isPasswordField(key)) return { type: "password", options: null };
  if (isDateString(value)) return { type: "date", options: null };
  return { type: "text", options: null };
}

/**
 * Converte uma chave em rótulo legível.
 * @param {string} key
 * @returns {string}
 */
function formatLabel(key) {
  return key.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase());
}

/**
 * Gera campos de formulário com base em um objeto de exemplo.
 * @param {Object} exampleObject
 * @returns {Array<{ name: string, label: string, type: string, options: Array|null }>}
 */
export function generateFormFields(exampleObject) {
  return Object.entries(exampleObject)
    .filter(([key]) => key !== "id" && key !== "_id")
    .map(([key, value]) => {
      const { type, options } = getFieldType(value, key);
      const label = formatLabel(key);
      return { name: key, label, type, options };
    });
}
