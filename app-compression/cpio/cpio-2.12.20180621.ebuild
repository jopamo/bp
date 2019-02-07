# Distributed under the terms of the GNU General Public License v2

EAPI=6

BASEVERSION="2.12"
MY_P="${PN}-${BASEVERSION}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="https://www.gnu.org/software/cpio/cpio.html"
SRC_URI="mirror://gnu//"${PN}/"${MY_P}.tar.bz2
		https://1g4.org/files/cpio-20180621.patch.tar.xz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nls"

PATCHES=( "${WORKDIR}/cpio-20180621.patch" )

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-rmt="${EROOT}"/usr/libexec/rmt
		--enable-mt
		$(use_enable nls)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

