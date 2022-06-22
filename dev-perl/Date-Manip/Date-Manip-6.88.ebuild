# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=SBECK

inherit perl-module

DESCRIPTION="Perl date manipulation routines"

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

src_test() {
	perl_rm_files t/pod_coverage.t t/pod.t
	TZ=UTC perl-module_src_test
}
