# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="The most popular spellchecking library dictionaries"
HOMEPAGE="http://hunspell.github.io/"
EGIT_REPO_URI="https://github.com/wooorm/dictionaries.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_install() {
	insinto /usr/share/hunspell
	newins dictionaries/en-US/index.aff en-US.aff
	newins dictionaries/en-US/index.dic en-US.dic
}
