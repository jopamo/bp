# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A TCP, UDP, and SCTP network bandwidth measurement tool"
HOMEPAGE="https://github.com/esnet/iperf"
EGIT_REPO_URI="https://github.com/esnet/iperf"

SNAPSHOT=67ca2c86b93716a812cb64e44e7cdecbbebe78e0
SRC_URI="https://github.com/esnet/iperf/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
