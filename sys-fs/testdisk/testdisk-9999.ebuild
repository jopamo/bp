# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools flag-o-matic

DESCRIPTION="TestDisk & PhotoRec: Checks/undeletes partitions & a signature based recovery tool"
HOMEPAGE="https://www.cgsecurity.org/wiki/TestDisk"
EGIT_REPO_URI="https://github.com/cgsecurity/testdisk.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="jpeg ntfs static zlib"

COMMON_DEPEND="
	static? (
		app-core/util-linux[static-libs]
		sys-fs/e2fsprogs[static-libs]
		lib-core/ncurses[static-libs]
		jpeg? ( xmedia-live-lib/libjpeg-turbo[static-libs] )
		ntfs? ( sys-fs/ntfs3g[static-libs] )
		zlib? ( lib-core/zlib[static-libs] )
	)
	!static? (
		app-core/util-linux
		sys-fs/e2fsprogs
		lib-core/ncurses:0=
		jpeg? ( xmedia-live-lib/libjpeg-turbo )
		ntfs? ( sys-fs/ntfs3g )
		zlib? ( lib-core/zlib )
	)
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="!static? ( ${COMMON_DEPEND} )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--disable-sudo
		--without-ntfs
		--without-ewf
		$(use_with jpeg)
		$(use_with ntfs ntfs3g)
		--disable-qt
		--without-reiserfs
		$(use_with zlib)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
