# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools

DESCRIPTION="Linux kernel firewall, NAT and packet mangling tools"
HOMEPAGE="https://netfilter.org/projects/nftables/"
SNAPSHOT=35cd3e7cff079c561ba616c792d5fdf13f6bd331
SRC_URI="https://github.com/1g4-mirror/nftables/archive/${SNAPSHOT}.tar.gz -> nftables-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/nftables-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug gmp readline router static-libs systemd"

DEPEND="
	lib-net/libmnl
	lib-net/libnftnl
	virtual/curses
	gmp? ( lib-core/gmp )
	readline? ( lib-core/readline )
"

pkg_setup() {
	CONFIG_CHECK="~NF_TABLES"
	linux-info_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_with readline cli=readline)
		$(use_with !gmp mini_gmp)
		$(use_enable static-libs static)
		--disable-man-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	keepdir /var/lib/nftables

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/nftables.service"
	fi

	insinto /etc
	if use router; then
		newins "${FILESDIR}/router.conf" nftables.conf
	else
		doins "${FILESDIR}/nftables.conf"
	fi
}
