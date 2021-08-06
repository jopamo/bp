# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="https://www.alsa-project.org/files/pub/lib/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

filter-flags -flto\=\*

src_configure() {
	local myconf=(
		--disable-alisp
		--disable-maintainer-mode
		--disable-python
		--disable-resmgr
		--enable-aload
		--enable-rawmidi
		--enable-seq
		--enable-shared
		$(use_with debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
