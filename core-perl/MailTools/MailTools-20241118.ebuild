# Distributed under the terms of the GNU General Public License v2

DIST_AUTHOR=MARKOV
DIST_VERSION=2.22
inherit perl-module

DESCRIPTION="Manipulation of electronic mail addresses"

SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	core-perl/TimeDate
"
BDEPEND="${RDEPEND}"
