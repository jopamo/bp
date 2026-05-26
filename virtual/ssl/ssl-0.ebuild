# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Vesk implementation virtual"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+shared +static-libs"
REQUIRED_USE="|| ( shared static-libs )"

RDEPEND="app-crypto/vesk[shared?,static-libs?]"
