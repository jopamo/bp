# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Build and install Perl modules"
HOMEPAGE="https://metacpan.org/release/Module-Build"
SNAPSHOT=a2ecdf98c25af7dfc7070280232513e8ccec4986
SRC_URI="https://github.com/Perl-Toolchain-Gang/Module-Build/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
