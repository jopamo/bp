# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=174c24d6e87aeae631bc0a7bb1ba983cf8def4de

inherit autotools flag-o-matic dot-a

DESCRIPTION="Extended crypt library for descrypt, md5crypt, bcrypt, and others"
HOMEPAGE="https://github.com/besser82/libxcrypt"
SRC_URI="https://github.com/besser82/libxcrypt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libxcrypt-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	use static-libs && lto-guarantee-fat

	filter-flags -flto*
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--disable-obsolete-api
		$(usex elibc_musl "--enable-hashes=strong" "--enable-hashes=strong,glibc")
		--disable-failure-tokens
		--disable-werror
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
