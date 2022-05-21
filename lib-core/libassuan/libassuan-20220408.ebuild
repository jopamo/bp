# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="84ae2b1d27ce81e87a8386918e48063dfd173d2e"
SHORT=${SNAPSHOT:0:7}

inherit autotools

DESCRIPTION="IPC library used by GnuPG and GPGME"
HOMEPAGE="http://www.gnupg.org/related_software/libassuan/index.en.html"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=${PN}.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SHORT}

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-core/libgpg-error"

PATCHES=( ${FILESDIR}/libassuan-nodocs.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}
