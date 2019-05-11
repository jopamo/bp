# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="bat doc +libsamplerate +ncurses nls"

CDEPEND=">=lib-media/alsa-lib-${PV}
	libsamplerate? ( lib-media/libsamplerate )
	ncurses? ( >=lib-sys/ncurses-5.7-r7:0= )
	bat? ( sci-libs/fftw:= )"
DEPEND="${CDEPEND}
	dev-util/pkgconf
	doc? ( app-text/xmlto )"
RDEPEND="${CDEPEND}
"
src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-maintainer-mode
		$(use_enable bat)
		$(use_enable libsamplerate alsaloop)
		$(use_enable nls)
		$(use_enable ncurses alsamixer)
		$(use_enable doc xmlto)
		--disable-alsaconf
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
		--with-udev-rules-dir="${EPREFIX}/$(get_udevdir)"/rules.d
		--with-asound-state-dir="${EPREFIX}"/var/lib/alsa
	)
	econf ${myconf[@]}
}

src_install() {
	default
	mkdir -p "${ED}"/var/lib/alsa/
	touch "${ED}"/var/lib/alsa/asound.state
	keepdir /var/lib/alsa
	keepdir /usr/share/alsa/ucm
}
