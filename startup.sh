mkdir $HOME/test-project-container
cd $HOME/test-project-container
curl -o - $HOME/test-project-container/Dockerfile https://raw.githubusercontent.com/PSControls/test-project/main/Dockerfile ?token=$(date +%s)
docker build --no-cache -t node-red-project .
docker run --name nr-container1 -p 1880:1880 node-red-project
