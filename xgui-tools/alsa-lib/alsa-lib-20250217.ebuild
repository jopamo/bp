# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SNAPSHOT=df8f1cc1ec9d9ee15be5e2c23ad25b9389fd8766
SRC_URI="https://github.com/alsa-project/alsa-lib/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +ucm"

DEPEND="ucm? ( xmedia-app/alsa-ucm-conf )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	filter-flags -flto*

	local myconf=(
		$(use_enable ucm)
		$(use_with debug)
		--disable-alisp
		--disable-maintainer-mode
		--disable-python
		--disable-resmgr
		--enable-aload
		--enable-rawmidi
		--enable-seq
		--enable-shared
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
