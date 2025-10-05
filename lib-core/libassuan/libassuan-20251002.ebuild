# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=7ecea1a9d3d31d143873a198bef5d71a3c56d1b1
SHORT=${SNAPSHOT:0:7}

inherit autotools

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
	#disable texi doc generation
	sed -i "/TEXINFOS\ /d" doc/Makefile.am || die

	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}
