# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="a set of small utilities that are useful in advanced password cracking"
HOMEPAGE="https://github.com/hashcat/hashcat-utils"
EGIT_REPO_URI=https://github.com/hashcat/hashcat-utils.git

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

S="${WORKDIR}/${P}/src"

src_install() {
	for i in *.bin; do
		newbin ${i} ${i/.bin}
	done
}
