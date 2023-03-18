# Use existing base Freesurfer container https://github.com/baxpr/fs-lean
FROM baxterprogers/fs-lean:7.2.0

# Add code to produce QA report and reformat stats
COPY src /opt/fsqa
ENV PATH /opt/fsqa:${PATH}
ENTRYPOINT ["xwrapper.sh","make_qa.sh"]
