# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Contains error handling functions used by GnuPG software"
HOMEPAGE="http://www.gnupg.org/related_software/libgpg-error"
SNAPSHOT=b973e43d0be8839990cc56d86e3ba575fd7efbb7
SRC_URI="https://github.com/gpg/libgpg-error/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-doc
		--disable-nls
		--enable-threads
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
	dobin src/gpg-error-config
}
