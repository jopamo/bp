# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"

SNAPSHOT=1a324205779a5f85d0cbf049643e17c471eee7d3
SRC_URI="https://github.com/alsa-project/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libsamplerate +ncurses nls systemd"

DEPEND="
	>=xmedia-live-lib/alsa-lib-${PV}
	libsamplerate? ( xmedia-live-lib/libsamplerate )
	ncurses? ( virtual/curses )
"

src_prepare() {
	eautoreconf
	default

	sed -i 's/alsactl/alsactl\ \-L/g' alsactl/alsa-{restore,state}.service.in
}

src_configure() {
	local myconf=(
		--disable-bat
		$(use_enable libsamplerate alsaloop)
		$(use_enable nls)
		$(use_enable ncurses alsamixer)
		--disable-xmlto
		--disable-alsaconf
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
