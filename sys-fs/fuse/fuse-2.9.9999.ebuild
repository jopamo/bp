# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 flag-o-matic

DESCRIPTION="An interface for filesystems implemented in userspace"
HOMEPAGE="https://github.com/libfuse/libfuse"
EGIT_REPO_URI="https://github.com/libfuse/libfuse.git"
EGIT_BRANCH="fuse_$(ver_cut 1)_$(ver_cut 2)_bugfix"

LICENSE="GPL-2 LGPL-2.1"
SLOT=2
KEYWORDS="amd64 arm64"

IUSE="test"

filter-flags -flto

src_prepare() {
	ln -s "${EPREFIX}"/usr/share/gettext/config.rpath config.rpath
	sed -i.bak -e "s/\/sbin/\/usr\/sbin/g" "configure.ac"
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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

