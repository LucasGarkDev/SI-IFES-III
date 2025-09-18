import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './src/global.css'
import VideoLocadora from './src/videoLocadora.jsx'

// este e o core server não mexer nele se quiser adicionar algo faça em App.jsx ou crie um novo app e chame aqui
createRoot(document.getElementById('root')).render(
  <StrictMode>
    <VideoLocadora />
  </StrictMode>,
)