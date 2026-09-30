# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="Run a command in a virtual X server environment"
HOMEPAGE="https://github.com/jopamo/bp"
SRC_URI=""
S="${WORKDIR}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/bx
	app-core/util-linux[getopt,mcookie]
	xgui-tools/xauth
	xgui-tools/xorg-server[xvfb]
"

src_test() {
	sh -n "${FILESDIR}/xvfb-run" || die
	sh "${FILESDIR}/test-xvfb-run" "${FILESDIR}/xvfb-run" || die
}

src_install() {
	dobin "${FILESDIR}/xvfb-run"
	doman "${FILESDIR}/xvfb-run.1"
	insinto /usr/share/licenses/${PN}
	doins "${FILESDIR}/LICENSE"
}
