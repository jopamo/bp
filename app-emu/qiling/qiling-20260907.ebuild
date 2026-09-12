# Distributed under the terms of the GNU General Public License v2

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	app-emu/capstone
	app-emu/unicorn
	dev-pypi/fuzzercorn
	dev-pypi/gevent
	dev-pypi/keystone-engine
	dev-pypi/multiprocess
	dev-pypi/pefile
	dev-pypi/pyelftools
	dev-pypi/python-fx
	dev-pypi/python-registry
	dev-pypi/pyyaml
	dev-pypi/questionary
	dev-pypi/r2libr
	dev-pypi/termcolor
	dev-pypi/unicornafl
"
# lockstep-pypi-deps: end
DESCRIPTION="Advanced Binary Emulation Framework"
HOMEPAGE="https://github.com/qilingframework/qiling"

SNAPSHOT=0a13c2438a112e548ef66086b3abee2d74d7997a
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
