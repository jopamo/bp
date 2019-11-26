# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="https://zlib.net/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/madler/zlib.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=d71dc66fa8a153fb6e7c626847095d9697a6cf42
	SRC_URI="https://github.com/madler/zlib/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="ZLIB"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	"${S}"/configure \
		--shared \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/lib"
}

src_install() {
	default

	use static-libs || rm -f "${ED}"/usr/lib/libz.{a,la} #419645
}
