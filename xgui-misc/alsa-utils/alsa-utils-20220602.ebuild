# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"

SNAPSHOT=a566f8a0ed6d7ca5fd6ae2d224f3f28654a2f3be
SRC_URI="https://github.com/alsa-project/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsamixer libsamplerate systemd"

DEPEND="
	xgui-misc/alsa-lib
	libsamplerate? ( xmedia-live-lib/libsamplerate )
	alsamixer? ( virtual/curses )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-alsaconf
		--disable-bat
		--disable-nls
		--disable-xmlto
		--with-asound-state-dir="${EPREFIX}"/var/lib/alsa
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--with-udev-rules-dir="${EPREFIX}"/usr/lib/udev/rules.d
		$(use_enable alsamixer)
		$(use_enable libsamplerate alsaloop)
	)
	econf ${myconf[@]}
}

src_install() {
	default
	keepdir /var/lib/alsa
}
