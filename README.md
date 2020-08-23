# DockerFile to build image for fast.ai course

This Dockerfile makes it easy to run the Practical Deep Learning for Coders Fastai coursev4 on your local machine. 

Unlike other images these just provide the jupyter notebook environment with all dependencies and you keep the actual fast.ai repo on you local server to mount into the docker container. I just found this easier for when it comes to saving your work.

These images have inbuilt CUDA support but require you to have installed the [NVIDIA Driver](https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#how-do-i-install-the-nvidia-driver) and [nvidia-docker packages](https://github.com/NVIDIA/nvidia-docker/)

## How to build docker image

From the repo directory run:

`chmod +x build.sh`
`./build.sh`

## How to run a container from the image

Run the following command replacing **[local-path]** with the path to the course-v4 repo on your local system.

`docker run -it -d --rm --gpus=all --shm-size=1g -p 8888:8888 -v [local-path]/course-v4:/fastai/course-v4 --name course-v4 donbale/fastai-docker:stable`

Your jupiter notebook will be available at localhost:8888 on your local machine.
