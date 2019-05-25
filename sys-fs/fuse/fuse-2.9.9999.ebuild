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

IUSE="test static-libs"

filter-flags -flto\=\*

src_prepare() {
	ln -s "${EROOT}"/usr/share/gettext/config.rpath config.rpath
	sed -i.bak -e "s/\/sbin/\/usr\/sbin/g" "configure.ac"
	sed -i.bak -e "s/\/etc\/udev\/rules.d/\/usr\/lib\/udev\/rules.d/g" "configure.ac"
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm -rf "${ED}"/etc/init.d
	use static-libs || find "${ED}" -name '*.a' -delete
}
