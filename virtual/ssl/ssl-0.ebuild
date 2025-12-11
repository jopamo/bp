# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Openssl implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libressl"

RDEPEND="libressl? ( lib-net/libressl
			!lib-net/openssl )
	!libressl? ( lib-net/openssl
			!lib-net/libressl )"
