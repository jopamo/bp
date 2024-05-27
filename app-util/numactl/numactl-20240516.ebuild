# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Utilities and libraries for NUMA systems"
HOMEPAGE="https://github.com/numactl/numactl"

SNAPSHOT=87342c3b9a42aadbe1398ca8233d13ab524aa64f
SRC_URI="https://github.com/numactl/numactl/archive/${SNAPSHOT}.tar.gz -> numactl-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/numactl-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

filter-flags -Wl,-z,defs

src_prepare() {
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
