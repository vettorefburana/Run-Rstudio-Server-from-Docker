# Run-Rstudio-Server-from-Docker
Run RStudio Server from a Docker container and mount host directories to Docker home

The container is built from the following image from DockerHub:

```rb

rocker/verse:4.1.0

```

Execution: 

1) Add a ```packages``` directory on the host filesystem. This folder will be used for installing R packages locally from RStudio Server.

2) From the terminal, go to the folder where the Dockerfile and the .Rprofile files are (```${PWD}```) and run the container

```rb

docker run --rm \
-p 8888:8787 \ 
-v ${PWD}/packages:/packages \
-v ${PWD}/scripts:/home/rstudio/scripts \
-v ${PWD}/data:/home/rstudio/data \
-e PASSWORD=password \
rocker/verse:4.1.0

```
The .Rprofile file contains the line '.libPaths('/packages/')', which tells R to look for packages in /packages/. When the RStudio Server container is started, a volume is mounted which connects the local folder with all the R packages to the container filesystem, so that packages do not need to be re-installed every time a new container is started. Additionally, a volume ```scripts``` for storing R scripts and a volume ```data``` for the data directory are mounted.

