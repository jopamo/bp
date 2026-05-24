# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=92587b7bf5ffbdd34e2139f3563211cd2d04f652
SHORT=${SNAPSHOT:0:7}

inherit autotools qa-policy

DESCRIPTION="IPC library used by GnuPG and GPGME"
HOMEPAGE="http://www.gnupg.org/related_software/libassuan/index.en.html"
SRC_URI="https://github.com/gpg/libassuan/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libassuan-${SNAPSHOT}

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-core/libgpg-error"

src_prepare() {
	qa-policy-configure
	#disable texi doc generation
	sed -i "/TEXINFOS\ /d" doc/Makefile.am || die

	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

src_install() {
	default
	qa-policy-install
}
