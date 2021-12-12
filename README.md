# Run-Rstudio-Server-from-Docker

Objective: 
--------------------------------------------------------------------------------------------------------------------
Run RStudio Server from a Docker container and mount host directories to Docker home.

The container is built from the following image from DockerHub:

```rb

rocker/verse:4.1.0

```

Execution: 
---------------------------------------------------------------------------------------------------------------------------------
1) Add a ```packages``` directory on the host filesystem. This folder will be used for installing R packages locally from RStudio Server.

2) From the terminal, go to the folder where the Dockerfile and the .Rprofile files are (```${PWD}```) and run the container.

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

3) If the container ran without errors, access RStudio Server at http://localhost:8888/ and insert username ```rstudio``` and password ```password```.
4) On RStudio Server, set the library path to ```packages```, so that installed packages are stored locally and do not need to be re-installed every time.

```rb

.libPaths(new = "/packages")

```

After that, new packages can be installed via the ```install.packages()``` command. Remember to set the library path every time you run RStudio Server.

5) Once done, stop the container either via CTRL + C or ```docker stop```.

![image](https://user-images.githubusercontent.com/74903161/145717624-0d51a0cd-203a-4d2f-8e49-3bf15f9be62b.png)


Examples:
------------------------------------------------------------------------------------------------------------------------------------

This repository contains some example files to use in Rstudio Server. 

* The script ```analysis.R``` in ```scripts``` trains a RandomForest model using the data from  ```winequality-red.csv``` in ```data```
and saves a csv file with the ranked variable importance in the same folder. The R package ```randomForest``` must be installed in RStudio Server before running the script.
* The rmarkdown file ```report.R``` in ```scripts``` produces a report with some text and plots and saves it in the same folder.

References: 
------------------------------------------------------------------------------------------------------------------------------------
https://github.com/davetang/learning_docker


