# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic pam tmpfiles

DESCRIPTION="screen manager with VT100/ANSI terminal emulation"
HOMEPAGE="https://www.gnu.org/software/screen/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug pam"

DEPEND="
	>=lib-sys/ncurses-5.2:0=
	pam? ( lib-sys/pam )
	sys-devel/texinfo"

PATCHES=( ${FILESDIR}/854c3673bb69a07d0ebaa52c2cd31eebaeaaca2c.patch )

src_configure() {
	use debug && append-cppflags "-DDEBUG"

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-pty-group=5
		--enable-socket-dir="${EPREFIX}"/run/screens
		--with-system_screenrc="${EPREFIX}"/etc/screenrc
		$(use_enable pam)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insinto /usr/share/screen
	doins terminfo/{screencap,screeninfo.src}

	insinto /etc
	doins "${FILESDIR}"/screenrc

	pamd_mimic_system screen auth

	dotmpfiles "${FILESDIR}"/screen.conf
}
