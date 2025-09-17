const Navbar = () => {
  return (
    <nav className="flex items-center justify-between p-4 bg-black bg-opacity-90">
      <h1 className="text-red-600 font-bold text-2xl">Locadora</h1>
      <ul className="flex gap-6">
        <li><a href="/atores">Atores</a></li>
        <li><a href="/filmes">Filmes</a></li>
        <li><a href="/clientes">Clientes</a></li>
        <li><a href="/locacoes">Locações</a></li>
      </ul>
    </nav>
  );
};
export default Navbar;
