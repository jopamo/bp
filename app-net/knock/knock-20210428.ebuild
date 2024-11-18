# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A simple port-knocking daemon"
HOMEPAGE="http://www.zeroflux.org/projects/knock"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/jvinet/knock"
	inherit git-r3
else
	SNAPSHOT=cb163f1509f57698c40a1bd8d1d6891af608a18b
	SRC_URI="https://github.com/jvinet/knock/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+knockd"

DEPEND="knockd? ( lib-net/libpcap )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf $(use_enable knockd)
}
