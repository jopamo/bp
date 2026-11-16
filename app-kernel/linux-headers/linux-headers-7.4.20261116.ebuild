# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="snapshot"
SNAPSHOT=b576f55cfe947f5f92b3be629f88252bc861c0b2

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="headers"

inherit kernel-2

PROPERTIES+=" source-payload"

DESCRIPTION="Linux kernel headers"
HOMEPAGE="https://github.com/jopamo/k1g4"
SRC_URI="https://github.com/jopamo/k1g4/archive/${SNAPSHOT}.tar.gz -> k1g4-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/k1g4-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	kernel-2_src_install

	find "${ED}" \( -name '.install' -o -name '*.cmd' \) -delete || die
	# Delete empty directories
	find "${ED}" -empty -type d -delete || die
}
