# Use an appropriate base image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the application port (modify if needed)
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
