# Use the official Node.js 22 image based on Alpine 3.19
FROM node:22-alpine3.19

# Set environment variables for the project
ENV PROJECT_DIR=/home/node-red/project
ENV NODE_RED_VERSION=latest

# Create necessary directories
RUN mkdir -p ${PROJECT_DIR}

# Install necessary packages and Node-RED as root
RUN apk add --no-cache git \
    && npm install -g --unsafe-perm node-red@${NODE_RED_VERSION} 
    && npm install node-red-contrib-cip-ethernet-ip

# Set the working directory
WORKDIR ${PROJECT_DIR}

# Clone the GitHub repository as root
RUN git clone https://github.com/PSControls/test-project.git ${PROJECT_DIR}

# Change ownership of the project directory to the 'node' user
RUN chown -R node:node ${PROJECT_DIR}

# Switch to the 'node' user for better security
USER node

# Expose the default Node-RED port
EXPOSE 1880

# Start Node-RED with the project directory
CMD ["node-red", "--userDir", "/home/node-red/project"]
