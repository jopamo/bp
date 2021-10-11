# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="zlib replacement with optimizations for 'next generation' systems."
HOMEPAGE="https://github.com/zlib-ng/zlib-ng"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/zlib-ng/zlib-ng.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=ac9795400ebecfdf0c084e6d9c3da21ebf4d9462
	SRC_URI="https://github.com/zlib-ng/zlib-ng/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-ng-${SNAPSHOT}
fi

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}/usr"
		--zlib-compat
	)
	ECONF_SOURCE=${S} ./configure "${myconf[@]}"
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/lib/libz.{a,la}
}
