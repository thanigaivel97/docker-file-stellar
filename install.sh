
#!/usr/bin/env bash


set -ue


# install deps
apt-get update
apt-get install -y $STELLAR_CORE_BUILD_DEPS


# clone, compile, and install stellar core
#git clone --branch $STELLAR_CORE_VERSION --recursive --depth 1 https://github.com/thanigaivel97/sellar-core.git -b stellar-14.1
git clone https://github.com/thanigaivel97/stellar-core-prod.git -b inflation


cd stellar-core-prod
chmod 777 *
git submodule update --init --recursive
bash autogen.sh
./configure
make
make install
cd ..


# install confd for config file management
wget -nv -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${​​​​​​​CONFD_VERSION}​​​​​​​/confd-${​​​​​​​CONFD_VERSION}​​​​​​​-linux-amd64
chmod +x /usr/local/bin/confd


# cleanup
rm -rf stellar-core
apt-get remove -y $STELLAR_CORE_BUILD_DEPS
apt-get autoremove -y


# install deps
apt-get install -y $STELLAR_CORE_DEPS


# cleanup apt cache
rm -rf /var/lib/apt/lists/*
 










