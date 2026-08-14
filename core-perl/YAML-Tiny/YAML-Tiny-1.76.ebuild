# Distributed under the terms of the GNU General Public License v2

inherit perl-module qa-policy

DESCRIPTION="Read/Write YAML files with as little code as possible"
HOMEPAGE="https://metacpan.org/release/YAML-Tiny"
SRC_URI="https://cpan.metacpan.org/authors/id/E/ET/ETHER/YAML-Tiny-${PV}.tar.gz"
S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test minimal"

src_configure() {
	qa-policy-configure
	perl-module_src_configure
}

src_install() {
	perl-module_src_install
	qa-policy-install
}
