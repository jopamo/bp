# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Openssl implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libressl static-libs"

RDEPEND="libressl? ( lib-net/libressl[static-libs?]
			!lib-net/openssl )
	!libressl? ( lib-net/openssl[static-libs?]
			!lib-net/libressl )"
