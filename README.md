# Meteor-dev Meteor Docker Container for Development and Learning  

This docker image brings up a container with Meteor pre-installed.   

## Features  

1. Brings up the container as a non-root user with user name "appdev/appdev"  
2. Starts the container in ~/apps directory. Any files created in here will go away along with the container. So, this spacce can be used for learning project.  
3. Cotains fix for this often encountered MongoDb issue (https://github.com/meteor/meteor/issues/4019)  

## How to Use  

1. Start a Mongodb container ($ docker run --name mymongodb -d mongo)  
2. Launch this container  
	($ docker run -i -t --name <new_container_name> -v <host_dir>:<container_mount_dir> --link mymongodb:db_1 -p 80:3000 meteor-dev)   
    $ docker run -i -t --name meteor -v /host/Development:/develop --link mymongodb:db_1 -p 80:3000 meteor-dev  
