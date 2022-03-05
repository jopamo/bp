# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 git-r3

DESCRIPTION="Advanced Binary Emulation Framework"
HOMEPAGE="https://github.com/qilingframework/qiling"
EGIT_REPO_URI="https://github.com/qilingframework/qiling.git"
EGIT_BRANCH="dev"
EGIT_SUBMODULES=()

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-live/capstone[python]
	app-live/keystone[python]
	app-live/unicorn[python]
	dev-python/pyelftools
"
