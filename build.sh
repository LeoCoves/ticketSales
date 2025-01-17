#!/bin/bash

# Script para configurar el entorno de desarrollo para el proyecto

# 1. Verificar si Node.js está instalado y si no, instalarlo
echo "Verificando la instalación de Node.js..."
if ! command -v node &> /dev/null
then
    echo "Node.js no está instalado. Instalando Node.js..."
    # Usar NVM (Node Version Manager) para instalar la versión específica de Node.js
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    source ~/.bashrc
    nvm install 18.16.0  # Instalar la versión de Node.js que necesitas
    nvm use 18.16.0
else
    echo "Node.js ya está instalado."
fi

# 2. Verificar si npm está instalado y si no, instalarlo
echo "Verificando la instalación de npm..."
if ! command -v npm &> /dev/null
then
    echo "npm no está instalado. Instalando npm..."
    # Esto debería instalar npm junto con Node.js, pero por si acaso
    curl -L https://www.npmjs.com/install.sh | sh
else
    echo "npm ya está instalado."
fi

# 3. Instalar la versión específica de React si no está en package.json
echo "Verificando la instalación de React..."
REACT_VERSION="18.3.1"
REACT_DOM_VERSION="18.3.1"

# Comprobamos si la versión de React en package.json es la esperada
PACKAGE_JSON="package.json"
if grep -q "\"react\": \"$REACT_VERSION\"" $PACKAGE_JSON && grep -q "\"react-dom\": \"$REACT_DOM_VERSION\"" $PACKAGE_JSON
then
    echo "La versión de React y React DOM está correcta."
else
    echo "Instalando la versión correcta de React y React DOM..."
    npm install react@$REACT_VERSION react-dom@$REACT_DOM_VERSION
fi

# 4. Instalar dependencias del proyecto (asegúrate de que package-lock.json esté presente)
echo "Instalando dependencias del proyecto..."
npm install --legacy-peer-deps

# 5. Verificar si las dependencias se instalaron correctamente
echo "Verificando dependencias instaladas..."
if [ -d "node_modules" ]; then
    echo "Las dependencias se instalaron correctamente."
else
    echo "Hubo un error al instalar las dependencias."
    exit 1
fi

# 6. Configuración de Git (si es necesario)
echo "Configurando Git para manejar finales de línea..."
git config --global core.autocrlf true

# 7. Verificar si el proyecto tiene un archivo .gitattributes para normalizar los finales de línea
echo "Verificando archivo .gitattributes..."
if [ ! -f ".gitattributes" ]; then
    echo "Creando archivo .gitattributes para normalizar finales de línea..."
    echo "* text=auto" > .gitattributes
    git add .gitattributes
    git commit -m "Agregar .gitattributes para normalizar los finales de línea"
else
    echo "El archivo .gitattributes ya está presente."
fi

# 8. Verificar si web-vitals está instalado y, si no, instalarlo
echo "Verificando la instalación de web-vitals..."
npm list web-vitals || npm install web-vitals

# 9. Correr la aplicación para verificar que todo funcione
echo "Corriendo la aplicación para verificar la instalación..."
npm start
