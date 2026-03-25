# Distributed under the terms of the GNU General Public License v2

inherit perl-module

DESCRIPTION="Perl date manipulation routines"
HOMEPAGE="https://metacpan.org/release/Date-Manip"
SNAPSHOT=a88bc8c4a3e86c3b7661fcdc5a1f9ea8da20a3bf
SRC_URI="https://github.com/SBECK-github/Date-Manip/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

src_test() {
	perl_rm_files t/pod_coverage.t t/pod.t
	TZ=UTC perl-module_src_test
}
