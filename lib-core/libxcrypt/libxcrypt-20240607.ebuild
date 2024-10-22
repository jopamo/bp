# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=c832aa71019d4ef37790b7d1caa7d8f708850a1d

inherit autotools

DESCRIPTION="Extended crypt library for descrypt, md5crypt, bcrypt, and others"
HOMEPAGE="https://github.com/besser82/libxcrypt"
SRC_URI="https://github.com/besser82/libxcrypt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="glibc_compat static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(usex glibc_compat "--enable-obsolete-api=glibc" --disable-obsolete-api)
		--enable-hashes=strong,glibc
    	--disable-failure-tokens
    	--disable-werror
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
