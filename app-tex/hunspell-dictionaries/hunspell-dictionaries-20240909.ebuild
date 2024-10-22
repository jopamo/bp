# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The most popular spellchecking library dictionaries"
HOMEPAGE="http://hunspell.github.io/"

SNAPSHOT=8cfea406b505e4d7df52d5a19bce525df98c54ab
SRC_URI="https://github.com/wooorm/dictionaries/archive/${SNAPSHOT}.tar.gz -> dictionaries-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dictionaries-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto /usr/share/hunspell
	newins dictionaries/en/index.aff en-US.aff
	newins dictionaries/en/index.dic en-US.dic
}
