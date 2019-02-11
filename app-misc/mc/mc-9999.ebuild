# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="GNU Midnight Commander is a text based file manager"
HOMEPAGE="https://www.midnight-commander.org"
EGIT_REPO_URI="https://github.com/MidnightCommander/mc.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls test X"

RDEPEND=">=lib-dev/glib-2.26.0:2
	lib-sys/ncurses
	X? ( x11-libs/libX11
		x11-libs/libICE
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libSM )"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	test? ( lib-dev/check )
	"

src_prepare() {
	${S}/autogen.sh
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-vfs
		--with-screen=ncurses
		$(use_enable nls)
		$(use_enable test tests)
		$(use_with X x)
		--with-internal-edit
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc || die
}
