# ---- Base Node image ----
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the application code
COPY . .

# Expose the app port (usually 3000 or 8005)
EXPOSE 8080

# Start the app (use npm start or npm run dev depending on your script)
CMD ["npm", "run","dev"]



