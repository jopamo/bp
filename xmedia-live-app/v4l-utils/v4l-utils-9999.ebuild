# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools flag-o-matic xdg-utils

DESCRIPTION="Small CLI util to show EXIF infos hidden in JPEG files"
HOMEPAGE="https://git.linuxtv.org/v4l-utils.git"
EGIT_REPO_URI="https://git.linuxtv.org/v4l-utils.git"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xmedia-live-lib/libjpeg-turbo
"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
