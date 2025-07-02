# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="https://www.gnu.org/software/parted"
SRC_URI="mirror://gnu//${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug device-mapper nls readline static-libs"

RESTRICT="test"

DEPEND="
	app-fs/e2fsprogs
	device-mapper? ( app-fs/lvm2 )
	readline? ( lib-core/readline virtual/curses )
	nls? ( app-build/gettext )
"

PATCHES=(
	"${FILESDIR}"/${PN}-3.2-po4a-mandir.patch
	"${FILESDIR}"/${PN}-3.3-atari.patch
	"${FILESDIR}"/${PN}-3.4-posix-printf.patch
	"${FILESDIR}"/${PN}-3.6-tests-unicode.patch
	"${FILESDIR}"/${PN}-3.6-tests-non-bash.patch
	"${FILESDIR}"/${P}-underlinked-util-linux.patch
	"${FILESDIR}"/${P}-c23.patch
)

src_prepare() {
	filter-flags -Wl,-z,defs -flto\=\*
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		--disable-device-mapper
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with readline)
		--disable-rpath
		--disable-silent-rules
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
