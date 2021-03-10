# Distributed under the terms of the GNU General Public License v2

EAPI=7

PATCHES=( "${FILESDIR}"/more-uarches-for-gcc-v10-and-kernel-4.19-v5.4.patch )

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2 git-r3

DESCRIPTION="Linux kernel source tree"
HOMEPAGE="https://github.com/torvalds/linux"

EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git"
EGIT_BRANCH="linux-$(ver_cut 1).$(ver_cut 2).y"
EGIT_CLONE_TYPE="shallow"
S="${WORKDIR}/linux-${PV}"
EGIT_CHECKOUT_DIR="${S}"

LICENSE="GPL"
SLOT="$(ver_cut 1).$(ver_cut 2)"
KEYWORDS="amd64 arm64"

DEPEND="
	sys-app/ed
	sys-devel/bc
"
