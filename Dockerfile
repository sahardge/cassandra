FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive      

RUN git clone https://github.com/sahardge/cassandra.git
RUN cd cassandra && bash install.sh
mkdir /mountedvol         


WORKDIR /local/git/cassandra/rexster/rexster-server

EXPOSE 8182 8183 8184

VOLUME ["/mountedvol"]

# Define default command.
CMD ["bash"]
