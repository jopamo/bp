# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://git.alsa-project.org/${PN}.git"
else
	SRC_URI="https://www.alsa-project.org/files/pub/lib/${P}.tar.bz2"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="alisp debug"

filter-flags -flto\=\*

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
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
