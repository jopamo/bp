# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs linux-info flag-o-matic

DESCRIPTION="Linux Key Management Utilities"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static static-libs test"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/${PN}-1.5.10-disable-tests.patch
	"${FILESDIR}"/${PN}-1.5.9-header-extern-c.patch
)

src_prepare() {
	append-flags -ffat-lto-objects
	sed -i '/rpmspec/d' Makefile
	default
}

src_compile() {
	emake CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		INCLUDEDIR="${EPREFIX}"/usr/include \
		MANDIR="${EPREFIX}"/usr/share/man \
		ETCDIR="${EPREFIX}"/etc \
		SHAREDIR="${EPREFIX}"/usr/share/keyutils \
		LIBDIR="${EPREFIX}"/usr/lib \
		SBINDIR="${EPREFIX}"/usr/bin \
		BINDIR="${EPREFIX}"/usr/bin
}

src_install() {
	export NO_ARLIB=$(usex static-libs 0 1)

	emake CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		INCLUDEDIR="${ED}"/usr/include \
		MANDIR="${ED}"/usr/share/man \
		ETCDIR="${ED}"/etc \
		SHAREDIR="${ED}"/usr/share/keyutils \
		LIBDIR="${ED}"/usr/lib \
		SBINDIR="${ED}"/usr/bin \
		BINDIR="${ED}"/usr/bin \
		install

	dosym -r /usr/lib/libkeyutils.so.1 /usr/lib/libkeyutils.so
}
