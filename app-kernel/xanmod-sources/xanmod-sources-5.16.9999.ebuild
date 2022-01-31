# Distributed under the terms of the GNU General Public License v2

EAPI=8

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2 git-r3

DESCRIPTION="XanMod: Linux kernel source code tree"
HOMEPAGE="https://xanmod.org/"

EGIT_REPO_URI="https://github.com/xanmod/linux.git"
EGIT_BRANCH="$(ver_cut 1-2)"
S="${WORKDIR}/linux-${PV}"
EGIT_CHECKOUT_DIR="${S}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	app-core/ed
	app-build/bc
"
