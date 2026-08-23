# Distributed under the terms of the GNU General Public License v2

inherit linux-info autotools qa-policy

DESCRIPTION="Netlink API to the in-kernel nf_tables subsystem"
HOMEPAGE="https://netfilter.org/projects/nftables/"
SNAPSHOT=49a3d46438cec6842938c12ac3cd9ace242bde6c
SRC_URI="https://github.com/1g4-mirror/libnftnl/archive/${SNAPSHOT}.tar.gz -> libnftnl-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libnftnl-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-net/libmnl"
BDEPEND="
	app-dev/patchelf
	app-dev/pkgconf
"

pkg_setup() {
	CONFIG_CHECK="~NF_TABLES"
	linux-info_pkg_setup
}

src_prepare() {
	rm -rf build-aux
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure

	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	qa-policy-install
}
