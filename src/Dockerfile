# Base is the stock freesurfer docker image
FROM freesurfer/freesurfer:7.4.1

# We need a few additional packages for freeview and imagemagick
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install ImageMagick && \
    yum -y install xorg-x11-server-Xvfb xorg-x11-xauth && \
    yum -y install mesa-libGLU fontconfig libtiff mesa-dri-drivers-23.1.0 && \
    yum clean all

# And add our own code for custom post-processing and QC
COPY README.md /opt/fs-extensions/
COPY src /opt/fs-extensions/src

# System path needs the freesurfer python, plus our code
ENV PATH /opt/fs-extensions/src:${FREESURFER_HOME}/python/bin:${PATH}

# Entrypoint
ENTRYPOINT ["xwrapper.sh","entrypoint.sh"]
