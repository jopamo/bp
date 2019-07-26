# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://www.gnupg.org/"
EGIT_REPO_URI="https://github.com/gpg/libgcrypt.git"
EGIT_BRANCH="LIBGCRYPT-$(ver_cut 1).$(ver_cut 2)-BRANCH"

LICENSE="LGPL-2.1 MIT"
SLOT="0/18"
KEYWORDS="amd64 arm64"

IUSE="o-flag-munging static-libs"

DEPEND=">=lib-dev/libgpg-error-1.25"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-dependency-tracking
		--enable-noexecstack
		$(use_enable o-flag-munging O-flag-munging)
		$(use_enable static-libs static)
		--without-capabilities
		--disable-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
