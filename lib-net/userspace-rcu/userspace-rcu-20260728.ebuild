# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Userspace RCU (read-copy-update) library"
HOMEPAGE="https://liburcu.org/"
SNAPSHOT=645fdc9b720606440a3b1ed74ad394e8eaad796b
SRC_URI="https://github.com/urcu/userspace-rcu/archive/${SNAPSHOT}.tar.gz -> userspace-rcu-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/userspace-rcu-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-shared
		$(use_enable static-libs static)
	)

	econf "${myeconfargs[@]}"
}

src_test() {
	default

	emake -C tests/regression regtest

	rm tests/benchmark/test-suite.log || die
}

src_install() {
	default
	qa-policy-install

	find "${ED}" -type f -name "*.la" -delete || die
}
