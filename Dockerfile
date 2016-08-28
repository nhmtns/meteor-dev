FROM ubuntu:14.04

MAINTAINER srini_vanga

LABEL description="This image sets up base container with specific techstack for Meteor Development. \
to see the details of techstack, type *docker inspect* command.

# ---------------------------------------
# To use:
# 	Build a container with this file ($ docker build -t meteor-dev)
#   Launch this container ($ docker run -i -t --name <new_container_name> -v <host_dir>:<container_mount_dir> --link mymongodb:db_1 -p 80:3000 meteor-dev)
#   Example : assuming your mongodb container name is mymongodb,
#   $ docker run -i -t --name meteor -v /host/Development:/develop --link mymongodb:db_1 -p 80:3000 meteor-dev
# ---------------------------------------

RUN apt-get update -qq \
&& apt-get -y dist-upgrade \
&& apt-get install -y vim curl \
&& apt-get clean \
&& rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ----------------------------------------
# Fix mongodb locale issue (see https://github.com/meteor/meteor/issues/4019)
#RUN locale-gen en_US.UTF-8 \
#&& localedef -i en_GB -f UTF-8 en_US.UTF-8
RUN update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX

LABEL meteor="latest"


# ---------------------------------------
# Define Techstack versions
ENV METEOR_RELEASE=latest

# -----------------------------------------
# setup container environment
ENV APP_USER=appdev
ENV APP_USER_HOME_DIR=/home/$APP_USER
ENV APPS_ROOT_DIR=/home/$APP_USER/apps

# ---------------------------------------
# Create a system type user account to run as in the container
RUN mkdir $APP_USER_HOME_DIR \ 
&& groupadd -r $APP_USER \
&& useradd -r -g $APP_USER -d $APP_USER_HOME_DIR -s /sbin/nologin -c "Meteor image user" $APP_USER \
&& echo "$APP_USER:$APP_USER" | chpasswd


# ---------------------------------------
# Download and install mateor installer
RUN curl -o /tmp/meteor.sh https://install.meteor.com/ 
# RUN curl https://install.meteor.com/ | sh 

RUN sh /tmp/meteor.sh \
&& mv ~/.meteor $APP_USER_HOME_DIR  \
&& chown -R $APP_USER:$APP_USER $APP_USER_HOME_DIR \
&& rm /tmp/meteor.sh
# TODO: parse install script and extract meteor version info etc. Hence for now saving it to tmp directory and deleting.  

WORKDIR $APPS_ROOT_DIR 
ENV PATH=$PATH:$APP_USER_HOME_DIR/.meteor

USER $APP_USER
CMD ["/bin/bash"]
