# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info systemd

DESCRIPTION="Linux kernel (3.13+) firewall, NAT and packet mangling tools"
HOMEPAGE="https://netfilter.org/projects/nftables/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +gmp +readline static-libs systemd"

RDEPEND="lib-net/libmnl
		gmp? ( lib-dev/gmp )
		readline? ( lib-sys/readline )
		lib-net/libnftnl"

DEPEND="${RDEPEND}
	sys-devel/bison
	app-text/docbook2X
	sys-devel/flex
	dev-util/pkgconf"

pkg_setup() {
	CONFIG_CHECK="~NF_TABLES"
	linux-info_pkg_setup
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
		$(use_with readline cli)
		$(use_with !gmp mini_gmp)
		$(use_enable static-libs static)
		--disable-man-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	keepdir /var/lib/nftables

	use systemd && systemd_dounit "${FILESDIR}"/${PN}.service

	insinto /etc
	doins "${FILESDIR}/nftables.conf"
}
