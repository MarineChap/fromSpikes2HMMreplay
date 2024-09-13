#Packaging repository for the clusterless decoding project

+ Step 1 : Install docker https://docs.docker.com/desktop

+ Step 2 : Download and run the docker image from github registry 

`docker run -p 8888:8888 -v /path/to/data:/home/jovyan/data -v /path/to/HippocampalSWRDynamics/project:/home/jovyan/HippocampalSWRDynamics ghcr.io/marinechap/fromspikes2hmmreplay:1.0.1`

> :warning: In waiting for the right github permission, the docker image is pushed on a fork on my github but will be removed later. 

**Option explanation** 

  + *-p 8888:8888* : **This option is mandatory** ! It allows you to access the jupyterlab instance

  + *-v /path/to/data:/home/jovyan/data* : allow you to have your data folder accessible inside jupyterlab. 

  + *-v /path/to/HippocampalSWRDynamics/project:/home/jovyan/HippocampalSWRDynamics*: **Optional** as the HippocampalSWRDynamics is already cloned and installed inside the jupyterlab but this allows you to have your own repository instead and have your change saved even if you close the docker image.


+ Step 3 : Open jupyterlab - the link is in the logs following the previous docker command :  http://127.0.0.1:8888/lab/{token}

> :warning: If you close the docker image, all modification not done inside a mounted folder (-v) will be lost. Don't forget to git pull/git push at the start and the end of a session. 

If you are always re-installing a library the best is to add it in the requirements.txt file, push the modification in github, then push a tag. 
The new image will be available few minutes later. 

`docker run -p 8888:8888 -v /path/to/data:/home/jovyan/data -v /path/to/HippocampalSWRDynamics/project:/home/jovyan/HippocampalSWRDynamics ghcr.io/marinechap/fromspikes2hmmreplay:{tag}`
