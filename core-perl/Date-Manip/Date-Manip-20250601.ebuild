# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Perl date manipulation routines"
HOMEPAGE="https://metacpan.org/release/Date-Manip"
SNAPSHOT=80b496189e86463faaf0ea382e7012648482ec0b
SRC_URI="https://github.com/SBECK-github/Date-Manip/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

src_test() {
	perl_rm_files t/pod_coverage.t t/pod.t
	TZ=UTC perl-module_src_test
}
