# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/gpg/libgcrypt.git"
	EGIT_BRANCH="LIBGCRYPT-$(ver_cut 1).$(ver_cut 2)-BRANCH"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=7ba5d831d573750af6a1f09713e07eeab6ccf5f3
	SRC_URI="https://github.com/gpg/libgcrypt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/libgcrypt-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="LGPL-2.1 MIT"
SLOT="0"

IUSE="o-flag-munging static-libs"

DEPEND="lib-core/libgpg-error"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-dependency-tracking
		--enable-noexecstack
		$(use_enable o-flag-munging O-flag-munging)
		$(use_enable static-libs static)
		--without-capabilities
		--disable-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
