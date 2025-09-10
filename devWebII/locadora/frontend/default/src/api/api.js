import axios from "axios";

const {VITE_ENV} = import.meta.env; // não process.env
// const { NODE_ENV } = process.env;
const url = VITE_ENV === "development" ? "http://localhost:3001/api" : "/api";
const resArtists = await axios.get(`${url}/artists`);
const resSongs = await axios.get(`${url}/songs`);
export const artistArray = resArtists.data;
export const songsArray = resSongs.data;