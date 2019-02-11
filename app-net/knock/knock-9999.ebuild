# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="A simple port-knocking daemon"
HOMEPAGE="http://www.zeroflux.org/projects/knock"
EGIT_REPO_URI="https://github.com/jvinet/knock.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+server"

DEPEND="server? ( lib-net/libpcap )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf $(use_enable server knockd)
}

src_install() {
	emake DESTDIR="${D}" docdir="${EROOT}/usr/share/doc/${PF}" install
}
