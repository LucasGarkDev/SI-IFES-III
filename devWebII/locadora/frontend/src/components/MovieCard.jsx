const MovieCard = ({ movie }) => {
  return (
    <div className="w-40 flex-shrink-0">
      <img
        src={movie.posterUrl}
        alt={movie.nome}
        className="rounded shadow-md hover:scale-105 transition-transform"
      />
      <p className="mt-2 text-sm text-center">{movie.nome}</p>
    </div>
  );
};

export default MovieCard;
