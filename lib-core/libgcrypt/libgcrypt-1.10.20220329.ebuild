# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="13b5454d2620701863f6e89221f5f4c98d2aba8e"
SHORT=${SNAPSHOT:0:7}

inherit flag-o-matic autotools

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=libgcrypt.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SHORT}

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="o-flag-munging static-libs"

DEPEND="lib-core/libgpg-error"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable o-flag-munging O-flag-munging)
		$(use_enable static-libs static)
		--disable-dependency-tracking
		--disable-doc
		--disable-jent-support
		--enable-noexecstack
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
