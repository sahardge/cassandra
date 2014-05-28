echo "Installing Rexter..."
git clone https://github.com/tinkerpop/rexster.git
cd rexster
mvn clean install

# Install [Titan](http://thinkaurelius.github.io/titan/)

# Argument is the version to install, or default value
VERSION=${1:-'0.4.2'}
IP=${2:-'10.10.10.100'}
BACKEND=cassandra #"server" includes rexter, cassandra, and all other backend/indexing support
TITAN=titan-${BACKEND}-${VERSION}

if [ ! -d /usr/local/${TITAN} ]; then
echo "Installing Titan ${VERSION}..."
  cd /usr/local
  FILE=${TITAN}.zip
  curl --silent -LO http://s3.thinkaurelius.com/downloads/titan/${FILE}
  unzip -qo ${FILE}
  rm -f ${FILE}
  echo "Titan has been installed."
  cd ${TITAN}
  #set rexster/doghouse address
  #mv conf/rexster-cassandra.xml conf/rexster-cassandra-es.xml.orig
  #cat conf/rexster-cassandra.xml.orig | sed -e "/<base-uri>/s/localhost/""$IP""/" > conf/rexster-cassandra-es.xml
  #bump rexster heap size
  #cp bin/rexster.sh bin/rexster.sh.orig
  #sudo bash -c 'cat bin/rexster.sh.orig | sed -e "/-server/s/-Xms128m -Xmx512m/-Xms128m -Xmx2048m -XX:MaxPermSize=256m/" > bin/rexster.sh'
  #sudo chmod a+x bin/rexster.sh
  #./bin/titan.sh start
  #start titan
  ./bin/gremlin.sh start
  ./bin/rexster.sh --start
  echo "Titan has been started."
  echo "Rexster Web Server has been started."
fi
