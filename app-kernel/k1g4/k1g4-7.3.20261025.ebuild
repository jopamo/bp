# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="snapshot"
SNAPSHOT=b07ef573a88491382335cdd5a0f985281b522796

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://kernel.org/"
SRC_URI="https://gitlab.com/pjo/kone/-/archive/${SNAPSHOT}/kone-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/kone-${SNAPSHOT}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

BDEPEND="app-core/bx"

src_prepare() {
	eapply "${FILESDIR}/genksyms-flex-debug.patch"
	kernel-2_src_prepare

	#eapply "${FILESDIR}"/net-txq-bql-traces.patch
}
