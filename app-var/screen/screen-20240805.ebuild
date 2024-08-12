# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=47ae4771bbab098e7797648fa2c16d7e08a96653

inherit flag-o-matic autotools

DESCRIPTION="screen manager with VT100/ANSI terminal emulation"
HOMEPAGE="https://www.gnu.org/software/screen/"
SRC_URI="https://git.savannah.gnu.org/cgit/screen.git/snapshot/screen-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}/src

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug pam tmpfilesd"

DEPEND="
	app-build/texinfo
	pam? ( lib-core/pam )
	virtual/curses
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use debug && append-cppflags "-DDEBUG"

	local myconf=(
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

	if use pam; then
		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}/${PN}.pam" ${PN}
	fi

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		doins "${FILESDIR}/${PN}.conf"
	fi
}
