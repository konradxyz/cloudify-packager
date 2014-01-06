PKG_DIR="/packages/logstash"
VER_VAR="logstash-1.3.2-flatjar"
URL="https://download.elasticsearch.org/logstash/logstash/${VER_VAR}.jar"

echo "creating logstash package dir..."
sudo mkdir -p ${PKG_DIR}
cd ${PKG_DIR}
echo "getting logstash ${VER_VAR}"
sudo wget ${URL}

cd /vagrant/scripts
