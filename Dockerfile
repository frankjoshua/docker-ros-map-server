FROM ros:noetic-ros-base

RUN apt-get update -y && \
  apt-get install -y ros-$ROS_DISTRO-map-server ros-$ROS_DISTRO-tf &&\
  apt-get -y clean &&\
  apt-get -y purge &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /app
COPY ./app /app
WORKDIR /app
CMD ["roslaunch", "--wait", "ros.launch"]

HEALTHCHECK CMD /ros_entrypoint.sh rostopic list || exit 1