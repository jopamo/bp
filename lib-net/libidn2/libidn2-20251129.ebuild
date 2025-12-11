# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="implementation of IDNA2008, Punycode and Unicode TR46"
HOMEPAGE="https://www.gnu.org/software/libidn/"
SNAPSHOT=192e61180a0446e2066a6cc550afd934e79ba8b8
SRC_URI="https://github.com/jopamo/libidn2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
