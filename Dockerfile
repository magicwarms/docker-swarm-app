# Menggunakan Node.js sebagai base image
FROM node:18

LABEL maintainer="Andhana Utama <andhanautama@gmail.com>"

# Mengatur working directory di dalam container
WORKDIR /app

# Menyalin package.json dan menginstall dependencies
COPY package.json ./
RUN npm install

# Menyalin file aplikasi ke dalam working directory
COPY . .

# Menentukan port yang digunakan aplikasi
EXPOSE 3000

# Menjalankan aplikasi
CMD ["npm", "start"]
