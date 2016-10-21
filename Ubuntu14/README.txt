Steps to build an AppImage of oaCapture using an Ubuntu14 Docker image.

# 1. Create a Docker image with the provided Dockerfile
# (start docker service if not already running. E.g.: arch linux: "systemctl start docker")
sudo docker build -t oacapture .

# 1.b Run created image => creates an instance
# (--privileged is needed for fuse to work for testing)
sudo docker run --name oacapture_instance --privileged -i -t oacapture

# 2. Build oacapture (Inside docker, after 1.b)
./build_1_oacapture.sh

# 3. Fetch and build AppImageKit
./build_2_appimagekit.sh

# 4. Build oacapture.AppImage
./build_3_oaCaptureAppImage.sh

# 5. Copy AppImage to host system.


#
# Useful Docker commands
#

# Stop instance
sudo docker stop oacapture_instance

# Start instance
sudo docker start oacapture_instance -i

# Remove instance
sudo docker rm oacapture_instance

# Remove image
sudo docker rmi oacapture

# Copy file to instance
sudo docker cp build_oaCaptureAppImage.sh  oacapture_instance:/usr/local/src/