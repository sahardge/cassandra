FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive      
##Install Cassandra
RUN git clone https://github.com/sahardge/cassandra.git
RUN cd cassandra && bash install-cassandra.sh
RUN curl -s https://storage.googleapis.com/golang/go1.2.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
ADD . /opt/etcd
RUN cd /opt/etcd && ./build

#Make Persisted host directory
RUN mkdir /mountedvol     


EXPOSE 9160 9142 7000 7001


