# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A TCP, UDP, and SCTP network bandwidth measurement tool"
HOMEPAGE="https://github.com/esnet/iperf"
EGIT_REPO_URI="https://github.com/esnet/iperf"
SNAPSHOT=333fa4008e8666b943b0b7960bb8f2bdaf694833
SRC_URI="https://github.com/esnet/iperf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/iperf-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default

	# remove the install hook entirely
	sed -i \
		-e '/^install-exec-hook:/,/^[[:space:]]*$/ { /^install-exec-hook:/d; /ldconfig/d; }' \
		src/Makefile.am || die

	rm configure
	eautoreconf
}
