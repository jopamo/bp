# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Oracle's Java SE Runtime Environment"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="https://1g4.org/files/jre-$(ver_cut 1)u$(ver_cut 2)-linux-x64.tar.gz"

S=${WORKDIR}/jre1.$(ver_cut 1).0_$(ver_cut 2)

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
KEYWORDS="amd64"

DEPEND="!dev-lang/openjdk-jre"

RESTRICT="preserve-libs strip"

QA_PREBUILT="*"

src_compile() { :;}

src_install() {
	mkdir -p "${ED}"/opt/ || die
	cp -pPR	bin lib "${ED}"/opt/ || die
	rm -f "${ED}"/opt/lib/amd64/{libavplugin,libglassgtk2}* || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die
}
