# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=e34e0634a7192383dbb4445b6d7568e36baef675

inherit autotools

DESCRIPTION="Extended crypt library for descrypt, md5crypt, bcrypt, and others"
HOMEPAGE="https://github.com/besser82/libxcrypt"
SRC_URI="https://github.com/besser82/libxcrypt/archive/${SNAPSHOT}.tar.gz -> libxcrypt-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libxcrypt-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--enable-obsolete-api=glibc
		$(usex elibc_musl --enable-xcrypt-compat "")
		$(usex elibc_musl "--enable-hashes=strong" "--enable-hashes=strong,glibc")
    	--disable-failure-tokens
    	--disable-werror
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	dolib.so .libs/libcrypt.so.1.1.0
	dolib.so .libs/libcrypt.so.1
}
