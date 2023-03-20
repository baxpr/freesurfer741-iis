# Use existing base Freesurfer container https://github.com/baxpr/fs-lean
FROM baxterprogers/fs-lean:7.2.0

# We use fslstats from FSL
# https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.5.2-centos7_64.tar.gz
# Also see https://fsl.fmrib.ox.ac.uk/fsldownloads/manifest.csv
RUN wget -P /opt https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.5.2-centos7_64.tar.gz && \
    tar -zxf /opt/fsl-6.0.5.2-centos7_64.tar.gz -C /usr/local fsl/bin/fslstats && \
    rm /opt/fsl-6.0.5.2-centos7_64.tar.gz
ENV PATH=/usr/local/fsl/bin:${PATH}

# Couple of dependencies for FSL
RUN yum -y install epel-release && \
    yum -y install openblas-devel

# Install python3 and add needed modules. Note that making python3 
# the system default breaks yum, so we won't do that. Rather, spec
# python3 in the first line of python scripts
RUN yum -y install python3 && \
    yum clean all && \
    pip3 install pandas numpy nibabel

# Add code to produce QA report and reformat stats
COPY src /opt/fsqa
ENV PATH /opt/fsqa:${PATH}
ENTRYPOINT ["xwrapper.sh","make_qa.sh"]
