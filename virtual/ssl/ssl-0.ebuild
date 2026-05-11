# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Openssl implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+libressl static-libs"

RDEPEND="libressl? ( app-crypto/libressl2[static-libs?]
			!lib-net/openssl )
	!libressl? ( lib-net/openssl[static-libs?]
			!app-crypto/libressl2 )"
