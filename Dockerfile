FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive         
RUN git clone https://github.com/sahardge/cassandra.git
RUN cd cassandra && bash install.sh
         
# Set environment variables.
ENV NODE_ENV production 

# Define default command.
CMD ["bash"]
