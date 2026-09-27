# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="Socket latency and throughput benchmarking utility"
HOMEPAGE="https://gitlab.com/pjo/sockperf/"
SNAPSHOT=de048181fc3fe3e91dff38d2d601a271d2d9f3d6
SRC_URI="https://gitlab.com/pjo/sockperf/-/archive/${SNAPSHOT}/sockperf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sockperf-${SNAPSHOT}"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+tls tools"
RESTRICT="test"

DEPEND="tls? ( app-crypto/vesk[shared] )"
RDEPEND="${DEPEND}"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Dtests=false
		$(meson_use tls)
		-Dtls_provider=vesk
		-Dvma_api=false
		-Dxlio_api=false
		$(meson_use tools)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
