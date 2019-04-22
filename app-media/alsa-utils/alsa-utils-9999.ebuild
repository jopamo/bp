# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd git-r3 autotools

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
EGIT_REPO_URI="https://github.com/alsa-project/${PN}.git"

LICENSE="GPL-2"
SLOT="0.9"
KEYWORDS="amd64 arm64"
IUSE="+libsamplerate +ncurses nls"

DEPEND=">=lib-media/alsa-lib-${PV}
		libsamplerate? ( lib-media/libsamplerate )
		ncurses? ( >=lib-sys/ncurses-5.7-r7:0= )
		dev-util/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-maintainer-mode
		--disable-bat
		$(use_enable libsamplerate alsaloop)
		$(use_enable nls)
		$(use_enable ncurses alsamixer)
		--disable-xmlto
		--disable-alsaconf
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
		--with-udev-rules-dir="${EPREFIX}/$(get_udevdir)"/rules.d
		--with-asound-state-dir="${EPREFIX}"/var/lib/alsa
	)
	econf ${myconf[@]}
}

src_install() {
	mkdir -p "${ED}"/var/lib/alsa/
	touch "${ED}"/var/lib/alsa/asound.state
	default
	keepdir /var/lib/alsa
	keepdir /usr/share/alsa/ucm
}
