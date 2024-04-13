# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Advanced Binary Emulation Framework"
HOMEPAGE="https://github.com/qilingframework/qiling"

SNAPSHOT=9a78d186c97d6ff42d7df31155dda2cd9e1a7fe3
SRC_URI="https://github.com/qilingframework/qiling/archive/${SNAPSHOT}.tar.gz -> qiling-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qiling-${SNAPSHOT}"

EGIT_BRANCH="dev"
EGIT_SUBMODULES=()

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-emu/capstone[python]
	app-emu/keystone[python]
	app-emu/unicorn[python]
	dev-python/pyelftools
"
