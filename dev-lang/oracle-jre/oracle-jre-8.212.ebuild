# Distributed under the terms of the GNU General Public License v2

EAPI=7

KEYWORDS="amd64"

DESCRIPTION="Oracle's Java SE Runtime Environment"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="https://1g4.org/files/oracle-jre-${PV}.tar.xz"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
RESTRICT="preserve-libs strip"
QA_PREBUILT="*"

src_install() {
	mkdir -p "${ED}"/opt/ || die
	cp -pPR	bin lib "${ED}"/opt/ || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die
}
