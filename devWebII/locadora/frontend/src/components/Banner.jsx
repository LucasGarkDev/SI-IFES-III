const Banner = () => {
  return (
    <header className="relative h-[400px] bg-cover bg-center flex items-end p-8"
      style={{ backgroundImage: "url('https://via.placeholder.com/1280x400')" }}>
      <div>
        <h2 className="text-3xl font-bold">Filme em Destaque</h2>
        <p className="max-w-lg">Descrição breve do filme em destaque.</p>
        <button className="mt-3 bg-red-600 px-4 py-2 rounded">Assistir</button>
      </div>
    </header>
  );
};
export default Banner;
