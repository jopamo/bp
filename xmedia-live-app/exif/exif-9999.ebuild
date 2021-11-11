# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Small CLI util to show EXIF infos hidden in JPEG files"
HOMEPAGE="https://github.com/libexif"
EGIT_REPO_URI="https://github.com/libexif/exif.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/popt
	>=xmedia-live-lib/libexif-${PV}
"
BDEPEND="app-dev/pkgconf"

src_prepare() {
	default
	eautoreconf
}
