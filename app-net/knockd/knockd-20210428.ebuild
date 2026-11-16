# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Port-knocking daemon"
HOMEPAGE="https://www.zeroflux.org/projects/knock"
SNAPSHOT=cb163f1509f57698c40a1bd8d1d6891af608a18b
SRC_URI="https://github.com/jvinet/knock/archive/${SNAPSHOT}.tar.gz -> knock-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/knock-${SNAPSHOT}

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-net/libpcap"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --enable-knockd
}

src_compile() {
	emake knockd doc/knockd.1
}

src_install() {
	dosbin knockd src/knock_helper_ipt.sh
	insinto /etc
	doins knockd.conf
	doman doc/knockd.1
}
