# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Command-line tool for structural, content-preserving transformation of PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
SRC_URI="https://github.com/qpdf/qpdf/archive/release-${P}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( Apache-2.0 Artistic-2 )"
S=${WORKDIR}/${PN}-release-${P}
SLOT="0/18"
KEYWORDS="amd64 arm64 x86"

DEPEND="lib-media/libjpeg-turbo"

src_prepare() {
	${S}/autogen.sh
	eautoreconf
	default
}

src_configure() {
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
