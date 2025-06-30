# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="the network swiss army knife"
HOMEPAGE="http://nc110.sourceforge.net/"
SNAPSHOT=bd1ef015e011421f0494cbf28835ccdf5ec6765d
SRC_URI="https://github.com/jopamo/netcat/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="netcat"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 telnet exec_hole verbose_debug static"

src_configure() {
	append-flags "-Wno-pointer-sign -Wno-address -Wno-implicit-fallthrough -Wno-clobbered"

	local emesonargs=(
		$(meson_use ipv6)
		$(meson_use telnet)
		$(meson_use exec_hole)
		$(meson_use verbose_debug)
	)

	if use static; then
		append-ldflags -static
		emesonargs+=(
			-Ddefault_library=static
			-Db_staticpic=false
			-Dc_link_args="${LDFLAGS}"
		)
	fi
	meson_src_configure
}
