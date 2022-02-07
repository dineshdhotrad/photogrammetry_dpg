export TMP=$(pwd)
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq && apt-get upgrade -qq

apt-get install -y  \
  build-essential \
  libeigen3-dev \
  cmake \
  git \
  libeigen3-dev \
  libgoogle-glog-dev \
  libopencv-dev \
  libsuitesparse-dev \
  python3-dev \
  python3-numpy \
  python3-opencv \
  python3-pip \
  python3-pyproj \
  python3-scipy \
  python3-yaml \
  curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

curl -L http://ceres-solver.org/ceres-solver-2.0.0.tar.gz | tar xz && \
    cd $TMP/ceres-solver-2.0.0 && \
    mkdir -p build_cer && cd build_cer && \
    cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF && \
    make -j4 install && \
    cd $TMP/ceres-solver-2.0.0

git clone --recursive https://github.com/mapillary/OpenSfM ${TMP}/opensfm && \
  cd ${TMP}/opensfm && git checkout tags/v0.5.1 && \
  pip3 install -r requirements.txt && \
  python3 setup.py build

apt-get update -qq && apt-get upgrade -qq 

apt-get install -y \
  graphviz \
  libatlas-base-dev \
  libboost-filesystem-dev \
  libboost-iostreams-dev \
  libboost-program-options-dev \
  libboost-regex-dev \
  libboost-serialization-dev \
  libboost-system-dev \
  libboost-test-dev \
  libboost-graph-dev \
  libcgal-dev \
  libcgal-qt5-dev \
  libfreeimage-dev \
  libgflags-dev \
  libglew-dev \
  libglu1-mesa-dev \
  libjpeg-dev \
  libpng-dev \
  libqt5opengl5-dev \
  libtiff-dev \
  libxi-dev \
  libxrandr-dev \
  libxxf86vm-dev \
  libxxf86vm1 \
  mediainfo \
  mercurial \
  qtbase5-dev \
  libatlas-base-dev \
  libsuitesparse-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Get vcglib
git clone https://github.com/cdcseacave/VCG.git ${TMP}/vcglib

# Install OpenMVG
git clone -b develop --recursive https://github.com/openMVG/openMVG.git ${TMP}/openmvg && \
  cd ${TMP}/openmvg && git checkout tags/v2.0 && \
  mkdir ${TMP}/openmvg_build && cd ${TMP}/openmvg_build && \
  cmake -DCMAKE_BUILD_TYPE=RELEASE . ../openmvg/src -DCMAKE_INSTALL_PREFIX=/opt/openmvg && \
  make -j4  && \
  make install

# Install OpenMVS
git clone https://github.com/cdcseacave/openMVS.git ${TMP}/openmvs && \
  cd ${TMP}/openmvs && git checkout tags/v1.1.1 && \
  mkdir ${TMP}/openmvs_build && cd ${TMP}/openmvs_build && \
  cmake . ../openmvs -DCMAKE_BUILD_TYPE=Release -DVCG_DIR="../vcglib" -DCMAKE_INSTALL_PREFIX=/opt/openmvs && \
  make -j4 && \
  make install

# Install cmvs-pmvs
git clone https://github.com/pmoulon/CMVS-PMVS ${TMP}/cmvs-pmvs && \
  mkdir ${TMP}/cmvs-pmvs_build && cd ${TMP}/cmvs-pmvs_build && \
  cmake ../cmvs-pmvs/program -DCMAKE_INSTALL_PREFIX=/opt/cmvs && \
  make -j4 && \
  make install