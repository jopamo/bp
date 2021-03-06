# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=RAAB
inherit perl-module

DESCRIPTION="Perl library for parsing the output of nsgmls"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="dev-perl/Module-Build"

src_install() {
	perl-module_src_install
	dosym sgmlspl.pl /usr/bin/sgmlspl
}
