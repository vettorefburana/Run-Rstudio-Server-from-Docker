# Run-Rstudio-Server-from-Docker

Objective: 
--------------------------------------------------------------------------------------------------------------------
Run RStudio Server from a Docker container and mount host directories to Docker home.

Docker is a program that allows to launch and stop multiple operating systems (called containers) on your machine (the host).
Docker is designed to enclose environments inside an image / a container, thus solving dependency and reproducibility issues. All you need is an installation of Docker on your computer and the Dockerfile corresponding to the container you wish to utilize.

The container on this repository is built from the following image from DockerHub:

```rb

rocker/verse:4.1.0

```

Execution: 
---------------------------------------------------------------------------------------------------------------------------------
1) Add a ```packages``` directory on the host filesystem. This folder will be used for installing R packages locally from RStudio Server.

2) From the terminal, go to the folder where the Dockerfile and the .Rprofile files are and build the container:

```rb

docker build -t rstudio_server .

```
The Dockerfile specifies some latex and R packages to be installed when running the container; the list can be expanded with additional packages. If the image was built correctly you should see it in the list of images on disk when you run ```docker images```.

3) Run the container with the following command: 

```rb

docker run --rm \
-p 8888:8787 \ 
-v ${PWD}/packages:/packages \
-v ${PWD}/scripts:/home/rstudio/scripts \
-v ${PWD}/data:/home/rstudio/data \
-e PASSWORD=password \
rstudio_server

```
The .Rprofile file contains the line ```.libPaths('/packages/')```, which tells R to look for packages in ```packages```. When the RStudio Server container is started, a volume is mounted which lets the host filesystem share the folder where the R packages are saved with the container filesystem. That way, all the packages that will be saved in the folder by the container will persist after the container is turned off. Additionally, a volume ```scripts``` for storing R scripts and a volume ```data``` for the data directory are mounted (change ```${PWD}``` to your local directory).

3) If the container ran without errors, navigate to http://localhost:8888/, insert username ```rstudio``` and password ```password``` and you can start using Rstudio Server:

![image](https://user-images.githubusercontent.com/74903161/145717624-0d51a0cd-203a-4d2f-8e49-3bf15f9be62b.png)

5) In RStudio Server, set the library path to ```packages```, so that installed packages are stored locally and do not need to be re-installed every time:

```rb

.libPaths(new = "/packages")

```

After that, new packages can be installed via the ```install.packages()``` command. Remember to set the library path every time you run RStudio Server.

5) At this point, you can use R and Rmarkdown from RStudio Server as you usually would on your machine. You can also write and read files from your local filesystem, using the mounted volumes. Once you are done, stop the running container either via CTRL + C or ```docker stop```.

Examples:
------------------------------------------------------------------------------------------------------------------------------------

This repository contains some example files to use in Rstudio Server. 

* The script ```analysis.R``` in ```scripts``` trains a Random Forest model using the data from  ```winequality-red.csv``` in ```data```
and saves a csv file with the ranked variable importance in the same folder. The R package ```randomForest``` must be installed in RStudio Server before running the script.
* The rmarkdown file ```report.R``` in ```scripts``` produces a report with some text and plots and saves it in the same folder.

References: 
------------------------------------------------------------------------------------------------------------------------------------
https://github.com/davetang/learning_docker



