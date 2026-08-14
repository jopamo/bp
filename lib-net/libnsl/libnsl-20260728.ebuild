# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Public client interface for NIS(YP) and NIS+ in a IPv6 ready version"
HOMEPAGE="https://github.com/thkukuk/libnsl"
SNAPSHOT=c2702fcdf0610e6909ddd67d51cc8a17c1ba464b
SRC_URI="https://github.com/thkukuk/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0/3"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-net/libtirpc
"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-shared
		--disable-static
		--enable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
