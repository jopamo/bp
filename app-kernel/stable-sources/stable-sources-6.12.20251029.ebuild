# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="linux-$(ver_cut 1-2).y"
SNAPSHOT=4408a3d67ea73cb72b57992118eea98cf9a8e007

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://kernel.org/"
SRC_URI="https://gitlab.com/linux-kernel/stable/-/archive/${SNAPSHOT}/stable-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/stable-${SNAPSHOT}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/ed
	app-util/bc
"

src_prepare() {
	kernel-2_src_prepare

	eapply "${FILESDIR}"/reg.patch
}

