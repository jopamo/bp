# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="Display a histogram of diff changes"
HOMEPAGE="https://invisible-island.net/diffstat/"
SRC_URI="https://invisible-mirror.net/archives/${PN}/${P}.tgz"

LICENSE="HPND MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	qa-policy-configure
	econf
}

src_test() {
	local test_log="${T}"/test.log

	emake check > "${test_log}"
	if grep -q '^?? fail:' "${test_log}"; then
		cat "${test_log}"
		die "test comparisons failed"
	fi
}

src_install() {
	default
	qa-policy-install
}
