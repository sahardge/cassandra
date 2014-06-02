# Argument is the version to install, or default value
VERSION=${1:-'0.4.4'}
IP=${2:-'10.10.10.100'}
BACKEND=cassandra #"cassandra" includes rextser, cassandra, and all other backend/indexing support
TITAN=titan-${BACKEND}-${VERSION}
REXSTERHOME=/local/git/cassandra/rexster

echo "Installing Rexster..."
git clone https://github.com/tinkerpop/rexster.git
cd rexster
mvn clean install
mkdir -p ${REXSTERHOME}/rexster-server/ext/titan
cd ${REXSTERHOME}
mv /rexster-server/config/rexster.xml /rexster-server/config/rexster.xml.orig
cat /rexster-server/config/rexster.xml.orig | sed -e "/<base-uri>/s/localhost/""$IP""/" > /rexster-server/config/rexster.xml
#bump rexster heap size
cp /rexster-server/bin/rexster.sh /rexster-server/bin/rexster.sh.orig
sudo bash -c 'cat /rexster-server/bin/rexster.sh.orig | sed -e "/-server/s/-Xms128m -Xmx512m/-Xms128m -Xmx2048m -XX:MaxPermSize=256m/" > /rexster-server/bin/rexster.sh'
sudo chmod a+x /rexster-server/bin/rexster.sh

# Install [Titan](http://thinkaurelius.github.io/titan/)

if [ ! -d /usr/local/${TITAN} ]; then
echo "Installing Titan ${VERSION}..."
  cd /usr/local
  FILE=${TITAN}.zip
  curl --silent -LO http://s3.thinkaurelius.com/downloads/titan/${FILE}
  unzip -qo ${FILE}
  rm -f ${FILE}
  echo "Titan has been installed."
  cd ${TITAN}
  cp -r /local/git/cassandra/lib ${REXSTERHOME}/rexster-server/ext/titan
fi
