# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools linux-info multilib-minimal

DESCRIPTION="Netlink API to the in-kernel nf_tables subsystem"
HOMEPAGE="https://netfilter.org/projects/nftables/"
SRC_URI="https://netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/7"
KEYWORDS="amd64 arm64 x86"
IUSE="json static-libs test threads"

RDEPEND=">=lib-net/libmnl-1.0.0
	json? ( >=lib-dev/jansson-2.3 )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

REQUIRED_USE="test? ( json )"

pkg_setup() {
	CONFIG_CHECK="~NF_TABLES"
	linux-info_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_with json json-parsing)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_test() {
	default
	cd tests || die
	./test-script.sh || die
}
