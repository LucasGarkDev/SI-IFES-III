/* eslint-disable no-unused-vars */
import React from "react";
import { artistArray } from "../assets/database/atores2";
import { songsArray } from "../assets/database/songs";
import axios from "axios";
import { UNSAFE_getPatchRoutesOnNavigationFunction } from "react-router-dom";

function getSongsArrayFromArtist(artist) {
  return songsArray.filter((currSongObj) => currSongObj.artist === artist);
}

function getSongById(id) {
  const song = songsArray.filter((currSongObj) => currSongObj._id === Number(id))[0];
  return song;
}

// get artists
function getArtistById(id) {
  const artist = artistArray.filter((currArtistObj) => currArtistObj._id === Number(id))[0];
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

function getAudioProgress(currentTimeInSeconds,durationInSeconds){
  const progress = (currentTimeInSeconds/durationInSeconds)
  return `${progress * 100}%`
}

async function onErrorTelemetria(error){
  console.error("Erro ao detectado: ", error);
	await axios.post(`${url}/telemetria`, "Erro ao detectado: " + error)
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.error(error);
  });
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
  onErrorTelemetria
};