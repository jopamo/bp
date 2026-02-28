# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic dot-a

DESCRIPTION="Utilities and libraries for NUMA systems"
HOMEPAGE="https://github.com/numactl/numactl"
SNAPSHOT=da84fd9e18a50e3933c7cd40c22a72361692b4e8
SRC_URI="https://github.com/numactl/numactl/archive/${SNAPSHOT}.tar.gz -> numactl-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/numactl-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	use static-libs && lto-guarantee-fat

	filter-flags -Wl,-z,defs
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}

src_test() {
	if [ -d /sys/devices/system/node ]; then
		einfo "The only generically safe test is regress2."
		einfo "The other test cases require 2 NUMA nodes."
		emake regress2
	else
		ewarn "You do not have baseline NUMA support in your kernel, skipping tests."
	fi
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
