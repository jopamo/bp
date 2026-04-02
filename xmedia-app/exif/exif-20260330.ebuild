# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Small CLI util to show EXIF infos hidden in JPEG files"
HOMEPAGE="https://github.com/libexif"

SNAPSHOT=be912deb003e4dee50a20f74709068c83f06b863
SRC_URI="https://github.com/libexif/exif/archive/${SNAPSHOT}.tar.gz -> exif-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/exif-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/popt
	>=xmedia-lib/libexif-${PV}
"
BDEPEND="app-dev/pkgconf"

src_prepare() {
	default
	eautoreconf
}
