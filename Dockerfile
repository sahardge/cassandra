# Pull base image.
FROM dockerfile/java
 
# Get rexster server
RUN wget -q http://tinkerpop.com/downloads/rexster/rexster-server-2.5.0.zip && unzip rexster-server-2.5.0.zip -d /tmp/rexster
RUN mv /tmp/rexster/rexster-server-2.5.0/ /rexster-server
 #set rexster/doghouse address
RUN mv /rexster-server/config/rexster.xml /rexster-server/config/rexster.xml.orig
RUN cat /rexster-server/config/rexster.xml.orig | sed -e "/<base-uri>/s/localhost/""10.10.10.101""/" 	  > /rexster-server/config/rexster.xml
  #bump rexster heap size
RUN cp bin/rexster.sh bin/rexster.sh.orig
RUN sudo bash -c 'cat bin/rexster.sh.orig | sed -e "/-server/s/-Xms128m -Xmx512m/-Xms128m -Xmx2048m -XX:MaxPermSize=256m/" > bin/rexster.sh'

# Get rexster console
#RUN wget -q http://tinkerpop.com/downloads/rexster/rexster-console-2.5.0.zip
#RUN ls
#RUN unzip rexster-console-2.5.0.zip -d /tmp/rexster
#RUN mv /tmp/rexster/rexster-console-2.5.0/ /rexster-console

# Get titan
RUN wget -q http://s3.thinkaurelius.com/downloads/titan/titan-cassandra-0.4.4.zip && unzip titan-cassandra-0.4.4.zip -d /tmp/titan
RUN mv /tmp/titan/titan-cassandra-0.4.4/ /rexster-server/titan
 
# Define working directory.
WORKDIR /rexster-server

# Rexster ports
EXPOSE 8182 8183 8184

# Set environment variables.
ENV NODE_ENV production
 
# Define default command.
CMD ["bash"]
