# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="https://www.alsa-project.org/files/pub/utils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+libsamplerate +ncurses nls systemd"

DEPEND="
		>=xmedia-live-lib/alsa-lib-${PV}
		libsamplerate? ( xmedia-live-lib/libsamplerate )
		ncurses? ( lib-sys/ncurses )
"

src_configure() {
	local myconf=(
		--disable-maintainer-mode
		--disable-bat
		$(use_enable libsamplerate alsaloop)
		$(use_enable nls)
		$(use_enable ncurses alsamixer)
		--disable-xmlto
		--disable-alsaconf
		--with-udev-rules-dir="${EPREFIX}"/usr/lib/udev/rules.d
		--with-asound-state-dir="${EPREFIX}"/var/lib/alsa
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
	)

	econf ${myconf[@]}
}

src_install() {
	default

	keepdir /var/lib/alsa
	keepdir /usr/share/alsa/ucm2
}
