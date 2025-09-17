# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://kernel.org/"

SNAPSHOT=46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
SRC_URI="https://github.com/torvalds/linux/archive/${SNAPSHOT}.tar.gz -> linux-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/linux-${SNAPSHOT}"

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

