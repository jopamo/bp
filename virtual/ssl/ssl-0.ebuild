# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="LibreSSL2 implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="shared +static-libs"
REQUIRED_USE="|| ( shared static-libs )"

RDEPEND="app-crypto/libressl2[shared?,static-libs?]"
