# Distributed under the terms of the GNU General Public License v2

EAPI=8

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2 git-r3

DESCRIPTION="Linux kernel source tree"
HOMEPAGE="https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable"

EGIT_REPO_URI="https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable"
EGIT_BRANCH="linux-$(ver_cut 1-2).y"
S="${WORKDIR}/linux-${PV}"
EGIT_CHECKOUT_DIR="${S}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

DEPEND="
	app-core/ed
	app-build/bc
"
