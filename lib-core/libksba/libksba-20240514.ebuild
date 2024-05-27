# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=b02b0bea7d62a352a21678a247bcb20b5a9fbf39
SHORT=${SNAPSHOT:0:7}

inherit autotools

DESCRIPTION="X.509 and CMS (PKCS#7) library"
HOMEPAGE="http://www.gnupg.org/related_software/libksba"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=libksba.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SHORT}

LICENSE="LGPL-3+ GPL-2+ GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-core/libgpg-error"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
