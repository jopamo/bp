# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unix password-hashing provider with the libcrypt.so.1 compatibility ABI"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND="
	>=app-crypto/vesk-9999-r1[shared,static-libs?]
"
