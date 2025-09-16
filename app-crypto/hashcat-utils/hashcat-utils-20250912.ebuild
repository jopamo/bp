# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a set of small utilities that are useful in advanced password cracking"
HOMEPAGE="https://github.com/hashcat/hashcat-utils"
SNAPSHOT=b55e433d187e6b04c526f67ea508a0e98c3f814a
SRC_URI="https://github.com/hashcat/hashcat-utils/archive/${SNAPSHOT}.tar.gz -> hashcat-utils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hashcat-utils-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	#removes the .bin extensions
	for i in *.bin; do
		newbin ${i} ${i/.bin}
	done
}
