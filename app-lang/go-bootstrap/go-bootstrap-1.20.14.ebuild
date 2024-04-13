# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bootstrap package for dev-lang/go"
HOMEPAGE="https://golang.org"
BOOTSTRAP_DIST="https://dev.gentoo.org/~williamh/dist"
SRC_URI="
	amd64? ( ${BOOTSTRAP_DIST}/go-${PV}-linux-amd64-bootstrap.tbz )
	arm64? ( ${BOOTSTRAP_DIST}/go-${PV}-linux-arm64-bootstrap.tbz )
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="big-endian"

RESTRICT="strip"
QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	dodir /usr/lib
	mv go-*-bootstrap "${ED}/usr/lib/go-bootstrap" || die

	# testdata directories are not needed on the installed system
	rm -fr $(find "${ED}"/usr/lib/go-bootstrap -iname testdata -type d -print)
}
