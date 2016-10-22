Steps to build an AppImage of oaCapture using an Ubuntu14 Docker image.

# 1. Create a Docker image with the provided Dockerfile
# (start docker service if not already running. E.g.: arch linux: "systemctl start docker")
sudo docker build -t oacapture .

# 1.b Run created image => creates an instance
# (--privileged is needed for fuse to work for testing)
sudo docker run --name oacapture_instance --privileged -i -t oacapture
# (You shall now have a prompt from Ubuntu inside the Docker container)

# 2. Build oacapture (Inside docker, after 1.b)
./build_1_oacapture.sh

# 3. Fetch and build AppImageKit
./build_2_appimagekit.sh

# 4. Build oacapture.AppImage
./build_3_oaCaptureAppImage.sh
exit
# (You shall be back to your host system)

# 5. Copy AppImage to host system.
sudo docker cp oacapture_instance:/usr/local/src/oaCapture-1.0.0.AppImage .


#
# Useful Docker commands
#

# Stop instance
sudo docker stop oacapture_instance

# Start instance
sudo docker start oacapture_instance -i

# Show running instances
sudo docker ps

# Show all instances
sudo docker ps -a

# Remove instance
sudo docker rm oacapture_instance

# Remove image
sudo docker rmi oacapture

# Copy file to instance
sudo docker cp build_oaCaptureAppImage.sh  oacapture_instance:/usr/local/src/