# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Native Unix password-hashing provider"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND="
	app-crypto/vesk[shared,static-libs?]
"
