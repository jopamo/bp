# Distributed under the terms of the GNU General Public License v2

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Advanced Binary Emulation Framework"
HOMEPAGE="https://github.com/qilingframework/qiling"

SNAPSHOT=a42fb2857955165f1c9e789d1888293e0a2368ea
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
	dev-pypi/pyelftools
"
