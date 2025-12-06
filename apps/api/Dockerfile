FROM node:18-alpine
WORKDIR /app
COPY apps/api/package*.json ./
RUN npm install
COPY apps/api . .
EXPOSE 3001
CMD ["npm", "run", "dev"]
