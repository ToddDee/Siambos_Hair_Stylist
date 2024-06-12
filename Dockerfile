# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Set the environment variable to change the default port
ENV PORT 3003

# Expose the port the app runs on
EXPOSE 3003

# Define the command to run the app
CMD ["npm", "run", "dev"]
