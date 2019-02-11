# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils libtool multilib-minimal

DESCRIPTION="Library to handle, display and manipulate GIF images"
HOMEPAGE="https://sourceforge.net/projects/giflib/"
SRC_URI="mirror://sourceforge/giflib/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0/7"
KEYWORDS="amd64 arm64"
IUSE="doc static-libs"

RDEPEND="
	abi_x86_32? (
		!<=app-misc/emul-linux-x86-baselibs-20140406-r1
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32]
	)"
DEPEND="${RDEPEND}
	doc? ( app-text/xmlto )"

src_prepare() {
	default
	elibtoolize
}

multilib_src_configure() {
	local myeconfargs=(
		# No need for xmlto as they ship generated files.
		ac_cv_prog_have_xmlto=no

		$(use_enable static-libs static)
	)

	ECONF_SOURCE="${S}" \
	econf "${myeconfargs[@]}"
}
