# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Userspace RCU (read-copy-update) library"
HOMEPAGE="https://liburcu.org/"
SNAPSHOT=91b6c67ef0478f7193485a02e4d5064413aa3029
SRC_URI="https://github.com/urcu/userspace-rcu/archive/${SNAPSHOT}.tar.gz -> userspace-rcu-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/userspace-rcu-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

src_prepare() {
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

	find "${ED}" -type f -name "*.la" -delete || die
}
