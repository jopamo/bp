# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="A TCP, UDP, and SCTP network bandwidth measurement tool"
HOMEPAGE="https://github.com/esnet/iperf"
EGIT_REPO_URI="https://github.com/esnet/iperf"
SNAPSHOT=3a251925916b947fdf6077ab4bedadff571b8fa7
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
