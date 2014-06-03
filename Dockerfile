FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive         
RUN git clone https://github.com/sahardge/cassandra.git
RUN cd cassandra && bash titan1.sh
         
# Set environment variables.
ENV NODE_ENV production 

WORKDIR /local/git/cassandra/rexster/rexster-server
# Define default command.
CMD ["bash"]
