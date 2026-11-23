# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="snapshot"
SNAPSHOT=7d467b3b7186f139d58c4ed76b9a2c299f451984

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://github.com/jopamo/k1g4"
SRC_URI="https://github.com/jopamo/k1g4/archive/${SNAPSHOT}.tar.gz -> k1g4-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/k1g4-${SNAPSHOT}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

BDEPEND="app-core/bx"

src_prepare() {
	eapply "${FILESDIR}/k1g4-tools-boot-banner.patch"
	kernel-2_src_prepare
}
