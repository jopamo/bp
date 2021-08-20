# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tool for organizing and renaming video files."
HOMEPAGE="https://www.filebot.net/"
SRC_URI="https://1g4.org/files/FileBot_${PV}-portable.tar.xz"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="preserve-libs strip"
QA_PREBUILT="*"

RDEPEND="bin/oracle-jre"

S=${WORKDIR}

src_install() {
	mkdir -p "${ED}"/opt/filebot || die
	cp -pPR	"${S}"/* "${ED}"/opt/filebot/ || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die
}
