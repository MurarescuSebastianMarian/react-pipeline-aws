# Utilizăm o imagine de bază cu Node.js pentru a construi aplicația React
FROM node:latest as build

# Setăm directorul de lucru în container
WORKDIR /app

# Copiem fișierul package.json și package-lock.json (sau yarn.lock) în directorul de lucru
COPY package*.json ./

# Instalăm dependențele aplicației
RUN npm install

# Copiem întregul cod sursă al aplicației în directorul de lucru
COPY . .

# Construim aplicația React
RUN npm run build

# Utilizăm o imagine de bază cu Nginx
FROM nginx

# Copiem conținutul din folderul curent în directorul radacină al serverului web Nginx
# COPY . /usr/share/nginx/html
COPY --from=build /app/build /usr/share/nginx/html

# Expunem portul 80 pentru a putea accesa serverul web Nginx
EXPOSE 80

# Comandă implicită care va fi executată atunci când rulăm un container din imaginea noastră
CMD ["nginx", "-g", "daemon off;"]
