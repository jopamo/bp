# Distributed under the terms of the GNU General Public License v2

inherit python-single-r1

DESCRIPTION="Native host for the ff2mpv Firefox extension"
HOMEPAGE="https://github.com/woodruffw/ff2mpv"
# Local fork; upstream provenance is recorded in README.md.
SRC_URI=""
S="${WORKDIR}"

LICENSE="ff2mpv"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="${PYTHON_DEPS}"
RDEPEND="${PYTHON_DEPS}
	xmedia-app/mpv[cli,lua]
"

src_test() {
	"${EPYTHON}" -B "${FILESDIR}/test_ff2mpv.py" || die "Native host tests failed"
}

src_install() {
	python_doscript "${FILESDIR}/ff2mpv.py"

	insinto /usr/lib/mozilla/native-messaging-hosts
	doins "${FILESDIR}/ff2mpv.json"

	insinto /usr/share/licenses/${PN}
	doins "${FILESDIR}/LICENSE"
}
