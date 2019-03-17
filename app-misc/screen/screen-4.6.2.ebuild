# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic pam toolchain-funcs user

DESCRIPTION="screen manager with VT100/ANSI terminal emulation"
HOMEPAGE="https://www.gnu.org/software/screen/"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
	KEYWORDS="amd64 arm64"
else
	EGIT_REPO_URI="git://git.savannah.gnu.org/screen.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/${P}" # needed for setting S later on
	S="${WORKDIR}"/${P}/src
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug nethack pam multiuser"

DEPEND="
	>=lib-sys/ncurses-5.2:0=
	pam? ( lib-sys/pam )
	sys-app/texinfo"

PATCHES=(
	"${FILESDIR}"/${PN}-4.3.0-no-utempter.patch
	"${FILESDIR}"/${P}-utmp-exit.patch
)

pkg_setup() {
	enewgroup utmp 406
}

src_prepare() {
	default

	mv sched.h _sched.h || die
	sed -i '/include/ s:sched.h:_sched.h:' screen.h || die

	eautoreconf
}

src_configure() {
	append-cppflags "-DMAXWIN=${MAX_SCREEN_WINDOWS:-100}"

	use nethack || append-cppflags "-DNONETHACK"
	use debug && append-cppflags "-DDEBUG"

	econf \
		--with-socket-dir="${EPREFIX}/tmp/screen" \
		--with-sys-screenrc="${EPREFIX}/etc/screenrc" \
		--with-pty-mode=0620 \
		--with-pty-group=5 \
		--enable-rxvt_osc \
		--enable-colors256 \
		$(use_enable pam)
}

src_compile() {
	LC_ALL=POSIX emake comm.h term.h
	emake osdef.h

	emake -C doc screen.info
	default
}

src_install() {
	default

	local tmpfiles_perms tmpfiles_group

	if use multiuser || use prefix
	then
		fperms 4755 /usr/bin/screen-${PV}
		tmpfiles_perms="0755"
		tmpfiles_group="root"
	else
		fowners root:utmp /usr/bin/screen-${PV}
		fperms 2755 /usr/bin/screen-${PV}
		tmpfiles_perms="0775"
		tmpfiles_group="utmp"
	fi

	dodir /etc/tmpfiles.d
	echo "d /tmp/screen ${tmpfiles_perms} root ${tmpfiles_group}" \
		> "${ED}"/etc/tmpfiles.d/screen.conf

	insinto /usr/share/screen
	doins terminfo/{screencap,screeninfo.src}

	insinto /etc
	doins "${FILESDIR}"/screenrc

	pamd_mimic_system screen auth

	rm -rf "${ED}"/usr/share/doc
}
