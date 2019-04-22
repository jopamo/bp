# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic git-r3 autotools

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
EGIT_REPO_URI="https://github.com/alsa-project/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="alisp debug"

filter-flags -flto

src_prepare() {
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
		--disable-maintainer-mode
		--disable-python
		--enable-shared
		--disable-resmgr
		--enable-rawmidi
		--enable-seq
		--enable-aload
		$(use_with debug)
		$(use_enable alisp)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
