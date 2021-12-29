# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Oracle's Java SE Runtime Environment"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="https://1g4.org/files/jre-$(ver_cut 1)u$(ver_cut 2)-linux-x64.tar.gz"

S=${WORKDIR}/jre1.$(ver_cut 1).0_$(ver_cut 2)

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="preserve-libs strip"

QA_PREBUILT="*"

src_compile() { :;}

src_install() {
	HERE="${ED}"/opt/${PN}
	mkdir -p "${HERE}" || die
	cp -pPR	bin lib "${HERE}"/ || die
	rm -f "${HERE}"/lib/amd64/{libavplugin,libglassgtk2}* || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die
}
