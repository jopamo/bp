# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for various service managers"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="mbedtls"

RDEPEND="
	mbedtls? ( lib-net/mbedtls )
	!mbedtls? ( lib-net/libressl )
"
