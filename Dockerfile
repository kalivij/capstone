# Used official Node as a parent image
FROM node:latest

# Update package repository and install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx configuration
RUN rm /etc/nginx/sites-enabled/default

# Copy a custom Nginx configuration file for react app
COPY nginx.conf /etc/nginx/sites-enabled/

# Create app directory and set as a working directory
WORKDIR /usr/src/app

# Set NODE_OPTIONS environment variable
ENV NODE_OPTIONS="--openssl-legacy-provider"

# Install react app dependencies
COPY package*.json ./
RUN npm install

# Copy and Bundle react app source code
COPY . .

# Build the react app
RUN npm run build

# Make the Nginx aware of the new build
RUN echo "server {\n\tlisten 80;\n\troot /usr/src/app/build;\n\tindex index.html;\n\tserver_name localhost;\n}" > /etc/nginx/sites-enabled/default

# Expose port 80
EXPOSE 80

# Start Nginx and the react app when the container starts
CMD ["nginx", "-g", "daemon off;"]
