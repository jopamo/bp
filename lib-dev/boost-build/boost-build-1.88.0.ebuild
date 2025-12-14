# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_rs 1- _)"

DESCRIPTION="A system for large project software construction, simple to use and powerful"
HOMEPAGE="http://www.boost.org/doc/tools/build/index.html"
SRC_URI="https://downloads.sourceforge.net/project/boost/boost/${PV}/boost_${MY_PV}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
S="${WORKDIR}/boost_${MY_PV}/"

KEYWORDS="amd64 arm64"

src_compile() {
	pushd "${S}"/tools/build
		./bootstrap.sh --cxxflags="$CXXFLAGS $LDFLAGS"
	popd

	default
}

src_install() {
	dobin tools/build/b2
	dosym -r /usr/bin/b2 /usr/bin/bjam
}
