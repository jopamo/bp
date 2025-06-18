# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="https://people.redhat.com/sgrubb/libcap-ng/"
SNAPSHOT=3b6819b057fcd9289886961ea198d822ff26e373
SRC_URI="https://github.com/stevegrubb/libcap-ng/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python static-libs"

RESTRICT="test"

src_prepare() {
	filter-flags -Wl,-z,defs
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-python3
		$(usex python "--with-python3" "--without-python3")
		$(usex static-libs "--enable-static=yes" "--enable-static=no")
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
