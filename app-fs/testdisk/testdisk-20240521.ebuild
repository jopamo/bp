# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="TestDisk & PhotoRec: Checks/undeletes partitions & a signature based recovery tool"
HOMEPAGE="https://www.cgsecurity.org/wiki/TestDisk"

SNAPSHOT=c5f76352d90025ca49aa03e4774984f5fdafaee8
SRC_URI="https://github.com/cgsecurity/testdisk/archive/${SNAPSHOT}.tar.gz -> testdisk-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/testdisk-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="jpeg ntfs static zlib"

COMMON_DEPEND="
	static? (
		app-core/util-linux[static-libs]
		app-fs/e2fsprogs[static-libs]
		virtual/curses[static-libs]
		jpeg? ( xmedia-lib/libjpeg-turbo[static-libs] )
		ntfs? ( app-fs/ntfs3g[static-libs] )
		zlib? ( lib-core/zlib[static-libs] )
	)
	!static? (
		app-core/util-linux
		app-fs/e2fsprogs
		virtual/curses
		jpeg? ( xmedia-lib/libjpeg-turbo )
		ntfs? ( app-fs/ntfs3g )
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
