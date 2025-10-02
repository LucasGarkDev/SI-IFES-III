/* eslint-disable no-unused-vars */
import React from "react";
// import { artistArray } from "../assets/database/atores2";
// import { songsArray } from "../assets/database/songs";
import axios from "axios";
import modules from "../js/config/modules.js";
import { UNSAFE_getPatchRoutesOnNavigationFunction } from "react-router-dom";

function getSongsArrayFromArtist(artist) {
  return songsArray.filter((currSongObj) => currSongObj.artist === artist);
}

function getSongById(id) {
  const song = songsArray.filter(
    (currSongObj) => currSongObj._id === Number(id)
  )[0];
  return song;
}

// get artists
function getArtistById(id) {
  const artist = artistArray.filter(
    (currArtistObj) => currArtistObj._id === Number(id)
  )[0];
  return artist;
}

function getArtistByName(name) {
  return artistArray.filter((currArtistObj) => currArtistObj.name === name)[0];
}

function getRamdomIdFromArtist(artist) {
  const songsArrayFromArtist = getSongsArrayFromArtist(artist);
  const ramdomIndex = getRandomInt(songsArrayFromArtist.length - 1);

  return songsArrayFromArtist[ramdomIndex]._id;
}

function getItemFromId(id, array) {
  return array.find((item) => item._id === Number(id));
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
    if (Array.isArray(input.data) && input.data.length > 0 && typeof input.data[0] === "object") {
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
export {
  getRandomInt,
  getRandomBin,
  getRandomHex,
  formatTime,
  formatTimeInSeconds,
  getAudioProgress,
  getArtistByName,
  getArtistById,
  getSongsArrayFromArtist,
  getSongById,
  getRamdomIdFromArtist,
  onErrorTelemetria,
  findModuleConfig,
  extractKeys,
  getItemFromId,
};
