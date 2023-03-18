# Use existing base Freesurfer container https://github.com/baxpr/fs-lean
FROM baxterprogers/fs-lean:7.2.0

# We use fslstats from FSL
# https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.5.2-centos7_64.tar.gz
# Also see https://fsl.fmrib.ox.ac.uk/fsldownloads/manifest.csv
RUN wget -P /opt https://fsl.fmrib.ox.ac.uk/fsldownloads/fsl-6.0.5.2-centos7_64.tar.gz &&
    tar -zxf /opt/fsl-6.0.5.2-centos7_64.tar.gz -C /usr/local fsl/bin/fslstats &&
    rm /opt/fsl-6.0.5.2-centos7_64.tar.gz
ENV PATH=/usr/local/fsl/bin:${PATH}

# Add code to produce QA report and reformat stats
COPY src /opt/fsqa
ENV PATH /opt/fsqa:${PATH}
ENTRYPOINT ["xwrapper.sh","make_qa.sh"]
