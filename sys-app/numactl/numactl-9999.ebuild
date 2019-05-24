# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs flag-o-matic

DESCRIPTION="Utilities and libraries for NUMA systems"
HOMEPAGE="https://github.com/numactl/numactl"

if [[ "${PV}" = 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/numactl/numactl.git"
else
	SRC_URI="ftp://oss.sgi.com/www/projects/libnuma/download/${P}.tar.gz"
fi

KEYWORDS="amd64 arm64"
LICENSE="GPL-2"
SLOT="0"
IUSE="static-libs"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

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

src_install() {
	emake DESTDIR="${D}" install

	find "${ED%/}"/usr/ -name libnuma.la -delete || die
}
