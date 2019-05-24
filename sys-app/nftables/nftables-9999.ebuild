# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info systemd git-r3

DESCRIPTION="Linux kernel (3.13+) firewall, NAT and packet mangling tools"
HOMEPAGE="https://netfilter.org/projects/nftables/"
EGIT_REPO_URI="git://git.netfilter.org/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug +gmp +readline static-libs"

RDEPEND=">=lib-net/libmnl-1.0.3:0=
	gmp? ( lib-dev/gmp:0= )
	readline? ( lib-sys/readline:0= )
	>=lib-net/libnftnl-1.0.9:0="

DEPEND="${RDEPEND}
	sys-devel/bison
	app-text/docbook2X
	sys-devel/flex
	dev-util/pkgconf"

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
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
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

	systemd_dounit "${FILESDIR}"/${PN}.service
	cp "${FILESDIR}/nftables.conf" "${ED}"/etc/
}
