# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SNAPSHOT=42eeb5eca03accb9711698e3991551a22e762543
SRC_URI="https://github.com/alsa-project/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +ucm"

DEPEND="ucm? ( xmedia-live-app/alsa-ucm-conf )"

filter-flags -flto\*

src_prepare() {
	default
	eautoreconf
}

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
		$(use_enable ucm)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
