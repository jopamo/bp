# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=cc6c29735d59e832be67f487e0c74e049ceaea94
SHORT=${SNAPSHOT:0:7}

inherit autotools

DESCRIPTION="IPC library used by GnuPG and GPGME"
HOMEPAGE="http://www.gnupg.org/related_software/libassuan/index.en.html"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=libassuan.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${P}.tar.gz"
S=${WORKDIR}/libassuan-${SHORT}

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
