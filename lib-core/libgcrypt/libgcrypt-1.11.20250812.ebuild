# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="LIBGCRYPT-$(ver_cut 1-2)-BRANCH"
SNAPSHOT=5937b1730df8400f996d6b5a231f88e62e53ae98

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
