# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal

DESCRIPTION="Parallel bzip2 utility"
HOMEPAGE="https://github.com/kjn/lbzip2/"

SRC_URI="https://1g4.org/files/lbzip2-20150919.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	default
	dosym ${PN} usr/bin/bzip2
	dosym lbunzip2 usr/bin/bunzip2
	dosym lbzcat usr/bin/bzcat
}
