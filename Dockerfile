FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive      

RUN git clone https://github.com/sahardge/cassandra.git
RUN cd cassandra && bash install.sh
RUN mkdir /mountedvol     

# Deploy startup script
#ADD start.sh /usr/sbin


WORKDIR /usr/sbin

EXPOSE 9160 9142 7000 7001


# Define default command.
CMD ["start"]
