# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SNAPSHOT=4391f98f7f7d0e3c659959386cc5660fb5c5e4d8
SRC_URI="https://github.com/alsa-project/alsa-utils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/alsa-utils-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsamixer libsamplerate systemd"

DEPEND="
	xgui-tools/alsa-lib
	libsamplerate? ( xmedia-lib/libsamplerate )
	alsamixer? ( virtual/curses )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable alsamixer)
		$(use_enable libsamplerate alsaloop)
		--disable-alsaconf
		--disable-bat
		--disable-nls
		--disable-xmlto
		--with-asound-state-dir="${EPREFIX}"/var/lib/alsa
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--with-udev-rules-dir="${EPREFIX}"/usr/lib/udev/rules.d
	)
	econf ${myconf[@]}
}

src_install() {
	default
	keepdir /var/lib/alsa
}
