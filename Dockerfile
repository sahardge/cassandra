FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive      

RUN git clone https://github.com/sahardge/cassandra.git
RUN cd cassandra && bash titan1.sh
RUN mkdir /mountedvol     

# Deploy startup script
#ADD start.sh /usr/sbin


WORKDIR /rexster

EXPOSE 8182 8183 8184


