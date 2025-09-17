const MovieRow = ({ title, movies }) => {
  return (
    <section>
      <h3 className="text-xl font-semibold mb-3">{title}</h3>
      <div className="flex gap-3 overflow-x-scroll">
        {movies.length > 0 ? (
          movies.map((movie) => (
            <div key={movie.id} className="w-40 flex-shrink-0">
              <img src={movie.posterUrl || "https://via.placeholder.com/160x240"} alt={movie.nome} className="rounded" />
              <p className="mt-1 text-sm">{movie.nome}</p>
            </div>
          ))
        ) : (
          <p className="text-gray-400">Nenhum filme disponível</p>
        )}
      </div>
    </section>
  );
};
export default MovieRow;
