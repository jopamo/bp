# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="https://www.gnu.org/software/cpio/cpio.html"
SRC_URI="mirror://gnu/cpio/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}"/00_684b7ac5767e676cda78c161aeb7fe7b45a07529.patch
	"${FILESDIR}"/01_b1c85839bf1381f749dd45bf6a5a38924e3315a0.patch
	"${FILESDIR}"/02_df55fb19be545e22d023950263ed5d0756edf81e.patch
	"${FILESDIR}"/03_0c4ffde0bdc015b468626f7464e39659c6891a31.patch
	"${FILESDIR}"/04_641d3f489cf6238bb916368d4ba0d9325a235afb.patch
	"${FILESDIR}"/05_dd96882877721703e19272fe25034560b794061b.patch
	"${FILESDIR}"/06_dfc801c44a93bed7b3951905b188823d6a0432c8.patch
	"${FILESDIR}"/07_36684f6deb3178043fe72a8e2faca538fa2aae1.patch
	"${FILESDIR}"/09_86dacfe3e060ce95d5a2c0c5ec01f6437b0b6089.patch
)

src_configure() {
	local myconf=(
		--with-rmt="${EROOT}"/usr/libexec/rmt
		--enable-mt
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
