# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic multilib-minimal git-r3

DESCRIPTION="C library that resolves names asynchronously"
HOMEPAGE="https://c-ares.haxx.se/"
EGIT_REPO_URI="https://github.com/c-ares/c-ares.git"
LICENSE="MIT"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

# Subslot = SONAME of libcares.so.2
SLOT="0/2"

DOCS=( AUTHORS CHANGES NEWS README.md RELEASE-NOTES TODO )

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/ares_build.h
)

src_prepare() {
	eapply_user
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--enable-nonblocking \
		--enable-symbol-hiding \
		$(use_enable static-libs static)
}
