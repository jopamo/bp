# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="https://zlib.net/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/madler/zlib.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=79a0e447a0dfa32979420cb21cfb96d684b2c9d5
	SRC_URI="https://github.com/madler/zlib/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default

	#ldconfig is not used
	sed -i 's/ldconfig/false/g' configure
}

src_configure() {
	local myconf=(
		--shared
		--prefix="${EPREFIX}/usr"
		--libdir="${EPREFIX}/usr/lib"
	)
	ECONF_SOURCE=${S} ./configure "${myconf[@]}"
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/lib/libz.{a,la} #419645
}
