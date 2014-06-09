FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive      
##Install Cassandra
RUN git clone https://github.com/sahardge/cassandra.git
RUN cd cassandra && bash install-cass.sh

#Make Persisted host directory
RUN mkdir /mountedvol     


EXPOSE 9160 9142 7000 7001


