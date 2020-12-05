# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	sys-fs/e2fsprogs
	device-mapper? ( sys-fs/lvm2 )
	readline? ( lib-sys/readline lib-sys/ncurses )
	nls? ( sys-devel/gettext )
	"

PATCHES=(
	"${FILESDIR}"/00_22a4baba11ab299722e68f9ea37a53869afef7e1.patch
	"${FILESDIR}"/01_ca845aeeddb17343c9289816833ca352f7c0d87b.patch
	"${FILESDIR}"/03_8c50fec522f475c51e2aaa3c972ce4c6690dda92.patch
	"${FILESDIR}"/04_c6b61814cd4cf958e12d35a36184ff7d767e57d9.patch
	"${FILESDIR}"/05_691dabc930a6d544dfd8da787cddd159bab34b1e.patch
	"${FILESDIR}"/07_c21ee3827639343920d3f08cff319620d3582d2a.patch
	"${FILESDIR}"/08_45e4c689c81cc55f849d3f90168a6b89c0168191.patch
	"${FILESDIR}"/09_92e6b10305b248a4943b7aa147d0c43bca7c71e3.patch
	)

filter-flags -Wl,-z,defs -flto\=\*

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
