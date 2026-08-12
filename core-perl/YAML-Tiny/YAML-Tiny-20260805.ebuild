# Distributed under the terms of the GNU General Public License v2

inherit perl-module

DESCRIPTION="Read/Write YAML files with as little code as possible"
HOMEPAGE="https://metacpan.org/release/YAML-Tiny"
SNAPSHOT=81ac8f6da2d4fda9af324f26812e1936fe7a7c01
SRC_URI="https://github.com/Perl-Toolchain-Gang/YAML-Tiny/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test minimal"
