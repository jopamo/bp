# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="OpenRC manages the services, startup and shutdown of a host"
HOMEPAGE="https://github.com/openrc/openrc/"
SRC_URI="https://dev.gentoo.org/~williamh/dist/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="audit debug ncurses pam newnet static-libs sysv-utils"

PATCHES=(
		"${FILESDIR}"/0001-call-sbin-mkmntdirs-in-localmount-OpenRC-service.patch
		"${FILESDIR}"/0001-fsck-don-t-add-C0-to-busybox-fsck.patch
		"${FILESDIR}"/0004-hide-error-when-migrating-var-run-to-run.patch
		"${FILESDIR}"/0007-make-consolefont-service-compatible-with-busyboxs-se.patch
		"${FILESDIR}"/0009-Support-early-loading-of-keymap-if-kdb-is-installed.patch
		"${FILESDIR}"/0010-rc-mount-make-timeout-invocation-compatible-with-bus.patch
		"${FILESDIR}"/0012-gcc-10.patch
		"${FILESDIR}"/0013-fix-osclock.patch
	)

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

