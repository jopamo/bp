# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Read/Write YAML files with as little code as possible"
HOMEPAGE="https://metacpan.org/release/YAML-Tiny"
SNAPSHOT=0b3f6349d5fa2b65dbfd9e46e7ea83460f3eb631
SRC_URI="https://github.com/Perl-Toolchain-Gang/YAML-Tiny/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test minimal"
