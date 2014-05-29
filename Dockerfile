# Pull base image.
FROM dockerfile/java
 
# Get rexster server
RUN wget -q http://tinkerpop.com/downloads/rexster/rexster-server-2.5.0.zip
RUN unzip rexster-server-2.5.0.zip -d /tmp/rexster
RUN mv /tmp/rexster/rexster-server-2.5.0/ /rexster-server

# Get rexster console
RUN wget -q http://tinkerpop.com/downloads/rexster/rexster-console-2.5.0.zip
RUN unzip rexster-console-2.5.0.zip -d /tmp/rexster
RUN mv /tmp/rexster/rexster-console-2.5.0/ /rexster-console

# Get titan
RUN wget -q http://s3.thinkaurelius.com/downloads/titan/titan-cassandra-0.4.4.zip
RUN unzip titan-cassandra-0.4.4.zip -d /tmp/titan
RUN mv /tmp/titan/titan-cassandra-0.4.4/ /rexster-server/titan
 
# Define working directory.
WORKDIR /rexster-server

# Rexster ports
EXPOSE 8182 8183 8184

# Set environment variables.
ENV NODE_ENV production
 
# Define default command.
CMD ["bash"]
