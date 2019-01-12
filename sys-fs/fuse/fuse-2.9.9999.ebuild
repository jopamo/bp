# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 )

inherit autotools multilib-minimal git-r3 flag-o-matic

DESCRIPTION="An interface for filesystems implemented in userspace"
HOMEPAGE="https://github.com/libfuse/libfuse"
EGIT_REPO_URI="https://github.com/libfuse/libfuse.git"
EGIT_BRANCH="fuse_2_9_bugfix"

LICENSE="GPL-2 LGPL-2.1"
SLOT=2
KEYWORDS="amd64 arm64 x86"
IUSE="test"

filter-flags -flto

src_prepare() {
	default
	./makeconf.sh
	eautoreconf
}

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
