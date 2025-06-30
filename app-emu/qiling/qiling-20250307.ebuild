# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Advanced Binary Emulation Framework"
HOMEPAGE="https://github.com/qilingframework/qiling"

SNAPSHOT=a430518ef2026c3fa9d69df5831581b9ac3aa368
SRC_URI="https://github.com/qilingframework/qiling/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
