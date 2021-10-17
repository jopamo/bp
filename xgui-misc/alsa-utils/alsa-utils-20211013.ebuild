# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"

SNAPSHOT=0fd3022e82a9be2560c9344bfa8354f09cb47510
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
		$(use_enable libsamplerate alsaloop)
		$(use_enable alsamixer)
		--disable-alsaconf
		--disable-bat
		--disable-nls
		--disable-xmlto
		--with-asound-state-dir="${EPREFIX}"/var/lib/alsa
		--with-udev-rules-dir="${EPREFIX}"/usr/lib/udev/rules.d
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
	)
	econf ${myconf[@]}
}

src_install() {
	default
	keepdir /var/lib/alsa
}
