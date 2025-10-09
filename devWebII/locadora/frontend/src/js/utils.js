/* eslint-disable no-unused-vars */
import React from "react";
import axios from "axios";
import modules from "../js/config/modules.js";
import { UNSAFE_getPatchRoutesOnNavigationFunction } from "react-router-dom";

function getItemFromId(id, array) {
  const foundItem = array.find((item) => item._id === Number(id));
  return foundItem;
}

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

function getRandomBin(max) {
  return Math.floor(Math.random() * max).toString(2);
}

function getRandomHex(max) {
  return Math.floor(Math.random() * max).toString(16);
}

function formatTime(timeinSeconds) {
  const minutes = Math.floor(timeinSeconds / 60)
    .toString()
    .padStart(2, "0");
  const seconds = Math.floor(timeinSeconds - minutes * 60)
    .toString()
    .padStart(2, "0");

  return `${minutes}:${seconds}`;
}

function formatTimeInSeconds(timeString) {
  const splitArray = timeString.split(":");
  const minutes = Number(splitArray[0]);
  const seconds = Number(splitArray[1]);

  return seconds + minutes * 60;
}

function getAudioProgress(currentTimeInSeconds, durationInSeconds) {
  const progress = currentTimeInSeconds / durationInSeconds;
  return `${progress * 100}%`;
}

async function onErrorTelemetria(error) {
  console.error("Erro ao detectado: ", error);
  await axios
    .post(`${url}/telemetria`, "Erro ao detectado: " + error)
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.error(error);
    });
}

function findModuleConfig(moduleName) {
  return modules.find((mod) => mod.name == moduleName);
}

function extractKeys(input) {
  if (Array.isArray(input)) {
    // Caso: array de objetos
    if (input.length > 0 && typeof input[0] === "object" && input[0] !== null) {
      console.log("[extractKeys] input[0]:", input[0]);
      return Object.keys(input[0]);
    }
  } else if (typeof input === "object" && input !== null) {
    // Caso: objeto com propriedade `newPageFields`
    if (Array.isArray(input.newPageFields)) {
      console.log("[extractKeys] input.newPageFields:", input.newPageFields);
      return input.newPageFields;
    }

    // Caso: objeto com `data` que é array de objetos
    if (
      Array.isArray(input.data) &&
      input.data.length > 0 &&
      typeof input.data[0] === "object"
    ) {
      console.log("[extractKeys] input.data[0]:", input.data[0]);
      return Object.keys(input.data[0]);
    }

    // ✅ Caso: objeto plano
    console.log("[extractKeys] input:", input);
    return Object.keys(input);
  }

  // Caso nenhum foi válido
  console.warn("[extractKeys] Formato de input inesperado:", input);
  return [];
}

function removeIDs(params) {
  const processedFields = isValidArrayOfStrings
    ? fields
        .filter((field) => !/id/i.test(field)) // 🧠 Ignora qualquer campo que tenha "id"
        .map((field) => ({
          name: field,
          label: field
            .replace(/_/g, " ")
            .replace(/\b\w/g, (l) => l.toUpperCase()),
          type: "text",
        }))
    : [];
}

function getTitleItem(selectedItem) {
  if (selectedItem) {
    return (
      selectedItem.nome ||
      selectedItem.name ||
      selectedItem.titulo ||
      selectedItem.id ||
      selectedItem._id ||
      "Item Selecionado"
    );
  }
  return "";
}

function filtrarCampos(filtros, dados) {
  // Caso seja um array de objetos
  if (Array.isArray(dados)) {
    return dados.map((item) =>
      Object.fromEntries(
        Object.entries(item).filter(([chave]) => !filtros.includes(chave))
      )
    );
  }

  // Caso seja um objeto individual
  if (typeof dados === "object" && dados !== null) {
    return Object.fromEntries(
      Object.entries(dados).filter(([chave]) => !filtros.includes(chave))
    );
  }

  // Se não for objeto nem array, retorna como está (ou pode lançar erro)
  return dados;
}

export {
  getRandomInt,
  getRandomBin,
  getRandomHex,
  formatTime,
  formatTimeInSeconds,
  onErrorTelemetria,
  findModuleConfig,
  extractKeys,
  getItemFromId,
  getTitleItem,
  filtrarCampos,
};
