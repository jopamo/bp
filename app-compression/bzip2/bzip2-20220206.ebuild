# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="a high-quality data compressor."
HOMEPAGE="https://sourceware.org/bzip2/"
SRC_URI="https://sourceware.org/pub/bzip2/${P}.tar.gz"

SNAPSHOT=1ea1ac188ad4b9cb662e3f8314673c63df95a589
SRC_URI="https://github.com/libarchive/bzip2/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BZIP2"
SLOT="0"
#KEYWORDS="amd64 arm64"
