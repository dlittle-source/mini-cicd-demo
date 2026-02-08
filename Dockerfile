FROM node:20-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files FIRST
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --production

# Copy rest of app
COPY . .

# Expose port
EXPOSE 80

# Start app
CMD ["npm", "start"]


