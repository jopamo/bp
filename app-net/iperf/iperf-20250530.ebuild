# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A TCP, UDP, and SCTP network bandwidth measurement tool"
HOMEPAGE="https://github.com/esnet/iperf"
EGIT_REPO_URI="https://github.com/esnet/iperf"
SNAPSHOT=84c49f29f9a81cbde6cd11511151ca4128057858
SRC_URI="https://github.com/esnet/iperf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/iperf-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
