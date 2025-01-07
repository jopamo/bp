# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Small CLI util to show EXIF infos hidden in JPEG files"
HOMEPAGE="https://github.com/libexif"

SNAPSHOT=bad99af4a8afd4b6a68654503d1318590526c191
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
