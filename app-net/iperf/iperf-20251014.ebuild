# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A TCP, UDP, and SCTP network bandwidth measurement tool"
HOMEPAGE="https://github.com/esnet/iperf"
EGIT_REPO_URI="https://github.com/esnet/iperf"
SNAPSHOT=28976ad7b2a630da5fe12ec4b9c0596575821e0a
SRC_URI="https://github.com/esnet/iperf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/iperf-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
