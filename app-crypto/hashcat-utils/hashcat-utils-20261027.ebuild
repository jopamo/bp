# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="a set of small utilities that are useful in advanced password cracking"
HOMEPAGE="https://github.com/hashcat/hashcat-utils"
SNAPSHOT=854e7d90f5e1393e9b2d53bcb94819ce1b3790bb
SRC_URI="https://github.com/hashcat/hashcat-utils/archive/${SNAPSHOT}.tar.gz -> hashcat-utils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hashcat-utils-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	emake -f src/Makefile MAINTAINER_MODE=1 native
}

src_install() {
	#removes the .bin extensions
	local i name
	for i in bin/*.bin; do
		name=${i##*/}
		newbin "${i}" "${name%.bin}"
	done
}
