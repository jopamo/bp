# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="snapshot"
SNAPSHOT=ae881a0aba12c08f01d0a9afad0be9a6876dc79f

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
	kernel-2_src_prepare

	#eapply "${FILESDIR}"/net-txq-bql-traces.patch
}
