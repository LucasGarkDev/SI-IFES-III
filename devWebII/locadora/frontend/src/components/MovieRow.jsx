import MovieCard from "./MovieCard";

const MovieRow = ({ title, movies }) => {
  return (
    <section className="mb-8">
      <h3 className="text-xl font-semibold mb-3">{title}</h3>
      <div className="flex gap-3 overflow-x-auto">
        {movies.length > 0 ? (
          movies.map((movie) => <MovieCard key={movie.id} movie={movie} />)
        ) : (
          <p className="text-gray-400">Nenhum filme disponível</p>
        )}
      </div>
    </section>
  );
};

export default MovieRow;
