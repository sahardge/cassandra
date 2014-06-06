# Argument is the version to install, or default value
VERSION=${1:-'0.4.4'}
IP=${2:-'10.10.10.100'}
BACKEND=cassandra #"cassandra" includes rextser, cassandra, and all other backend/indexing support
TITAN=titan-${BACKEND}-${VERSION}
REXSTERHOME=/rexster

echo "Installing Rexster..."
wget -q http://tinkerpop.com/downloads/rexster/rexster-server-2.5.0.zip && unzip rexster-server-2.5.0.zip -d /tmp/rexster
mv /tmp/rexster/rexster-server-2.5.0/ /rexster
cd /rexster
mkdir -p ${REXSTERHOME}/ext/titan
cd ${REXSTERHOME}
mv config/rexster.xml config/rexster.xml.orig
cat config/rexster.xml.orig | sed -e "/<base-uri>/s/localhost/172.17.0.2/" > config/rexster.xml
#bump rexster heap size
cp bin/rexster.sh bin/rexster.sh.orig
sudo bash -c 'cat bin/rexster.sh.orig | sed -e "/-server/s/-Xms128m -Xmx512m/-Xms128m -Xmx2048m -XX:MaxPermSize=256m/" > bin/rexster.sh'
sudo chmod a+x bin/rexster.sh

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
  cp -r /local/git/cassandra/lib ${REXSTERHOME}/ext/titan
  cp -r /local/git/cassandra/lib /usr/local/${TITAN}
fi
