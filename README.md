## Meteor-dev - Docker Container for Meteor Development and Learning  

This docker image brings up a container with Meteor pre-installed.

Most containers I found on docker hub have assumed few things like a meteor app already exists etc., For learners like myself, i wanted a sandbox container to play around. 

### Features  

1. Brings up the container as a non-root user: appdev/appdev  
2. Starts the container in ~/apps directory. Any files created in here will go away along with the container. So, this space can be used for learning project.  
3. Cotains fix for [this often encountered MongoDb issue](https://github.com/meteor/meteor/issues/4019)  

### Launching this container 

1. Start a Mongodb container   
	`Ex: $ docker run --name mymongodb -d mongo`
2. Launch this container  
	`$ docker run -i -t --name <new_container_name> -v <host_dir>:<container_mount_dir> --link mymongodb:db_1 -p 80:3000 nhmtns/meteor-dev`    
	Example:            
	`$ docker run -i -t --name meteor -v /host/Development:/develop --link mymongodb:db_1 -p 80:3000 nhmtns/meteor-dev`   


### Using for Development  	

	1. cd to your project folder at the mount point ($ cd /develop)  
	2. run 'meteor' from the container  
	3. start editing project files using your fav editor installed on the host  
	4. see changes taking effect in the running instance   



### For Meteor Learners  

After launching this container, you will be in the ~/apps directory, simply type:  

	$ meteor create my-first-app  
	$ cd my-first-app  
	$ meteor  
	Type http://localhost in your browser 

Remember, your app directory (my-first-app) will go away once you shutdown-your container. If you want your project to persist, then you need to create it on the host folder that you mounted into the continer ("/develop" from the above How to Use example)  









