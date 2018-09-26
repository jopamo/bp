# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="https://github.com/dosfstools/dosfstools"
SRC_URI="https://github.com/dosfstools/dosfstools/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="+udev"

CDEPEND="udev? ( sys-app/systemd )"
DEPEND="${CDEPEND}
	udev? ( dev-util/pkgconfig )"
RDEPEND="${CDEPEND}"

src_configure() {
	econf $(use_with udev)
}
