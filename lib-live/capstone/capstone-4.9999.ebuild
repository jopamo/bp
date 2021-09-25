# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
EGIT_REPO_URI="https://github.com/aquynh/capstone.git"
EGIT_BRANCH="v$(ver_cut 1)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
