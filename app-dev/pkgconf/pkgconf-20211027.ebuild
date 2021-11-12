# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a program which helps to configure compiler and linker flags for development libraries"
HOMEPAGE="https://git.sr.ht/~kaniini/pkgconf"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="http://git.dereferenced.org/pkgconf/pkgconf.git"
	inherit git-r3
else
	SNAPSHOT=8d9d3de6eb8f0ffdbb859fce79cff89038e513c4
	SRC_URI="https://github.com/${PN}/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	dosym pkgconf usr/bin/pkg-config
	use static-libs || find "${ED}" -name '*.a' -delete
}
