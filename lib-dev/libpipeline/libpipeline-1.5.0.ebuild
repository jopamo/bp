# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit ltprune

DESCRIPTION="a pipeline manipulation library"
HOMEPAGE="http://libpipeline.nongnu.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs test"

DEPEND="dev-util/pkgconfig
	test? ( lib-dev/check )"

PATCHES=(
	"${FILESDIR}"/${PN}-1.4.1-gnulib-cygwin-sys_select.patch
	"${FILESDIR}"/${PN}-1.4.1-gnulib-darwin-program_name.patch
)

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
