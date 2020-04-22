# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs git-r3

DESCRIPTION="OpenRC manages the services, startup and shutdown of a host"
HOMEPAGE="https://github.com/openrc/openrc/"
EGIT_REPO_URI="https://github.com/OpenRC/${PN}.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="audit debug ncurses pam newnet static-libs
	sysv-utils"

src_compile() {
    _makeargs=(
	CFLAGS="${CFLAGS}"
	LDFLAGS="${LDFLAGS}"
	DESTDIR="${D}"
	BRANDING="1g4 Linux"
	LIBDIR="${EPREFIX}"/usr/lib
	SHLIBDIR="${EPREFIX}"/usr/lib
	LIBEXECDIR="${EPREFIX}"/usr/lib/openrc
	BINDIR="${EPREFIX}"/usr/bin
	SBINDIR="${EPREFIX}"/usr/sbin
	SYSCONFDIR="${EPREFIX}"/etc/openrc
	MKBASHCOMP=no
	MKNET=$(usex newnet)
	MKSELINUX=no
	MKSYSVINIT=$(usex sysv-utils)
	MKAUDIT=$(usex audit)
	MKPAM=$(usev pam)
	MKSTATICLIBS=$(usex static-libs)
	MKZSHCOMP=no
	DEBUG=$(usev debug)
	MKTERMCAP=$(usev ncurses)
)

	tc-export CC AR RANLIB
	emake "${_makeargs[@]}"
}

src_install() {
	emake "${_makeargs[@]}" install

}

