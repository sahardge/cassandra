    #
    # Ghost Dockerfile
    #
    # https://github.com/dockerfile/ghost
    #
     
    # Pull base image.
    FROM jamesdbloom/docker-java7-maven
     
    # Pull script
    RUN \
      git clone https://github.com/sahardge/cassandra.git && \
      cd cassandra && \
      bash install.sh 
      
     
     
   
     
    # Set environment variables.
    ENV NODE_ENV production
     
    # Define default command.
    CMD ["bash"]
