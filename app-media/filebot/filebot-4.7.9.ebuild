# Distributed under the terms of the GNU General Public License v2

EAPI=7

KEYWORDS="amd64"

DESCRIPTION="A tool for organizing and renaming your Movies, TV Shows and Anime as well as fetching subtitles and artwork."
HOMEPAGE="https://www.filebot.net/"
SRC_URI="https://1g4.org/files/FileBot_${PV}-portable.tar.xz"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
RESTRICT="preserve-libs strip"
QA_PREBUILT="*"
S=${WORKDIR}

src_install() {
	mkdir -p "${ED}"/opt/filebot || die
	cp -pPR	"${S}"/* "${ED}"/opt/filebot/ || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die
}
