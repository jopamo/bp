# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="https://github.com/dosfstools/dosfstools"
EGIT_REPO_URI="https://github.com/dosfstools/dosfstools.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="udev"

DEPEND="
		sys-devel/gettext
		udev? ( sys-app/systemd )
	"

src_prepare() {
	cp "${EROOT}"/usr/share/gettext/config.rpath ${S}/
	default
	eautoreconf
}

src_configure() {
	econf $(use_with udev)
}
