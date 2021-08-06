# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Small CLI util to show EXIF infos hidden in JPEG files"
HOMEPAGE="https://github.com/libexif"
EGIT_REPO_URI="https://github.com/libexif/exif.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls"

RDEPEND="lib-dev/popt
	 >=lib-media/libexif-${PV}"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	nls? ( sys-devel/gettext )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf $(use_enable nls)
}
