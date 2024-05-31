# Set variables
DEST_DIR="$HOME/test-project-container"
DOCKERFILE_URL="https://raw.githubusercontent.com/PSControls/test-project/main/Dockerfile"

# Create the destination directory if it doesn't exist
mkdir -p "${DEST_DIR}"

# Change to the destination directory
cd "${DEST_DIR}" || { echo "Failed to change directory to ${DEST_DIR}"; exit 1; }

# Download the Dockerfile
curl -o "${DEST_DIR}/Dockerfile" "${DOCKERFILE_URL}"

# Verify the download
if [ -f "${DEST_DIR}/Dockerfile" ]; then
    echo "Dockerfile has been successfully downloaded to ${DEST_DIR}"
else
    echo "Failed to download Dockerfile"
    exit 1
fi

# Build the Docker image
docker build --no-cache -t node-red-project .

# Check if the image was built successfully
if [ $? -ne 0 ]; then
    echo "Docker build failed"
    exit 1
fi

# Run the Docker container
docker run --name nr-container1 -p 1880:1880 -d node-red-project

# Check if the container started successfully
if [ $? -ne 0 ]; then
    echo "Docker run failed"
    exit 1
fi

echo "Node-RED container is up and running on port 1880"
