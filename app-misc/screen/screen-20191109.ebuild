# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=f66377f9927bf5a1857b1106b28008f3802e1f7b

inherit flag-o-matic pam tmpfiles autotools

DESCRIPTION="screen manager with VT100/ANSI terminal emulation"
HOMEPAGE="https://www.gnu.org/software/screen/"
SRC_URI="https://git.savannah.gnu.org/cgit/screen.git/snapshot/screen-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}/src

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug pam"

DEPEND="
	>=lib-sys/ncurses-5.2:0=
	pam? ( lib-sys/pam )
	sys-devel/texinfo"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use debug && append-cppflags "-DDEBUG"

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
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
