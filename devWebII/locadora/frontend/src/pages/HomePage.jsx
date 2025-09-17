import Navbar from "../components/Navbar";
import Banner from "../components/Banner";
import MovieRow from "../components/MovieRow";
import { lancamentosMock, maisLocadosMock } from "../assets/mock/movies";

const HomePage = () => {
  return (
    <div className="bg-black min-h-screen text-white">
      <Navbar />
      <Banner />
      <div className="px-6">
        <MovieRow title="Lançamentos" movies={lancamentosMock} />
        <MovieRow title="Mais Locados" movies={maisLocadosMock} />
      </div>
    </div>
  );
};

export default HomePage;
