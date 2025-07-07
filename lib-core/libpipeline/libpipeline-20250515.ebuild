# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a pipeline manipulation library"
HOMEPAGE="http://libpipeline.nongnu.org/"

SNAPSHOT=08844b33bd0c77c7567caf1641f3aa48045f3e3b
SRC_URI="https://gitlab.com/libpipeline/libpipeline/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="network-sandbox"

src_prepare() {
	sed -i 's|https://git.savannah.gnu.org/git/gnulib.git|https://github.com/1g4-mirror/gnulib.git|' bootstrap
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib
	./bootstrap
	default
}

src_configure() {
	econf $(use_enable static-libs static)
}
