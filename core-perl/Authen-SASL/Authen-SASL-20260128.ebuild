# Distributed under the terms of the GNU General Public License v2

DIST_AUTHOR=EHUELS
DIST_VERSION=2.2000
inherit perl-module

DESCRIPTION="Perl SASL interface"

SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	core-perl/Crypt-URandom
	core-perl/Digest-HMAC
"
BDEPEND="${RDEPEND}"
