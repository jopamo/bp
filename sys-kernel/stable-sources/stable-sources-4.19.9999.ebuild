# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"

inherit kernel-2 git-r3

SLOT=0
DESCRIPTION="Linux kernel source tree"
HOMEPAGE="https://github.com/torvalds/linux"
KEYWORDS="amd64 arm64"

DEPEND="sys-app/ed
		sys-devel/bc"

EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git"
EGIT_BRANCH=linux-4.19.y
EGIT_CLONE_TYPE=shallow
S="${WORKDIR}/linux-${PV}"
EGIT_CHECKOUT_DIR="${S}"
