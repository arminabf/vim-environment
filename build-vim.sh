set -e
set -u

version="vim-8.0"
builddir="vim80"

sudo apt-get remove vim-tiny vim-common vim-gui-common
# install X11 libs (needed for clipboard supported)
sudo apt-get install libx11-dev libxt-dev

if [ ! -f /usr/bin/python-config ];then
  echo "python-dev not available"
  exit 1
fi

pushd /tmp
wget --no-use-server-timestamps http://artfiles.org/vim.org/unix/${version}.tar.bz2
rm -rf ${builddir}
tar xf ${version}.tar.bz2
pushd ${builddir}
make clean
sudo make uninstall

# python3
#--enable-python3interp
#--with-python-config3-dir=<path>
./configure --with-features=huge \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/bin/python-config \
            --enable-perlinterp \
            --enable-gui=gtk \
            --enable-cscope \
            --enable-multibyte \
            --prefix=/usr \
            --with-x
make VIMRUNTIMEDIR=/usr/share/vim/${builddir}
sudo make install
popd
rm ${version}.tar.bz2
popd
