# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic qa-policy

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="https://people.redhat.com/sgrubb/libcap-ng/"
SNAPSHOT=a81468fa8b224a3fb9f948f58d4bff5c7ca1538f
SRC_URI="https://github.com/stevegrubb/libcap-ng/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python static-libs"

RESTRICT="test"

src_prepare() {
	qa-policy-configure
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

src_install() {
	default
	qa-policy-install
}
