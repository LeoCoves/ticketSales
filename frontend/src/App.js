import logo from './logo.svg';
import './App.css';
import { useState } from 'react';
import Axios from 'axios';

function App() {

  const [nombre, setNombre] = useState('');
  const [evento, setEvento] = useState('');
  const [fecha, setFecha] = useState('');
  const [edad, setEdad] = useState(0);
  const [descripcion, setDescripcion] = useState('');

  const add = () => {
    Axios.post('http://localhost:3001/create', {
      nombre: nombre,
      evento: evento,
      fecha: fecha,
      edad: edad,
      descripcion: descripcion
    }).then(()=>{
      alert("Process completed");
    });
  }

  return (
    <div className="App">
      <div className="datos">

        <label>
          Compañia: 
          <input onChange={(event)=>{
            setNombre(event.target.value);
          }} type="text" />
        </label>

        <label>
          Evento: 
          <input onChange={(event)=>{
            setEvento(event.target.value);
          }} type="text" />
        </label>

        <label>Fecha: 
          <input onChange={(event)=>{
            setFecha(event.target.value);
          }} type="text" />
        </label>

        <label>
          Edad minima: 
          <input onChange={(event)=>{
            setEdad(event.target.value);
          }} type="number" />
        </label>

        <label>Descripcion: 
          <input onChange={(event)=>{
            setDescripcion(event.target.value);
          }} type="text" />
        </label>

        <button onClick={add}>
          Enviar
        </button>
      </div>
    </div>
  );
}

export default App;
