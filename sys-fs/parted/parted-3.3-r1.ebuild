# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="https://www.gnu.org/software/parted"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug device-mapper nls readline static-libs"

RESTRICT="test"

RDEPEND="
	>=sys-fs/e2fsprogs-1.27
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	readline? ( >=lib-sys/readline-5.2:0= >=lib-sys/ncurses-5.7-r7:0= )"

DEPEND="
	${RDEPEND}
	nls? ( >=sys-devel/gettext-0.12.1-r2 )
	dev-util/pkgconf
"

PATCHES=(
	"${FILESDIR}"/c6b61814cd4cf958e12d35a36184ff7d767e57d9.patch
	"${FILESDIR}"/eaada0bc9e1cc8adb3a0260707d9474a3e01b835.patch
	"${FILESDIR}"/ca845aeeddb17343c9289816833ca352f7c0d87b.patch
)

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable device-mapper)
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with readline)
		--disable-rpath
		--disable-silent-rules
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
