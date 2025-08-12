# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="LIBGCRYPT-$(ver_cut 1-2)-BRANCH"
SNAPSHOT=bec3eeabc688f92b2d751f111b31e6ee38fd4dc5

inherit flag-o-matic autotools

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="https://github.com/gpg/libgcrypt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libgcrypt-${SNAPSHOT}

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="o-flag-munging static-libs"

DEPEND="lib-core/libgpg-error"

src_prepare() {
	filter-flags -fuse-ld=lld

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
