# Distributed under the terms of the GNU General Public License v2

EAPI=8

BASEVERSION="8.0.452"

DESCRIPTION="Zulu OpenJDK8 with JavaFX Support"
HOMEPAGE="https://www.azul.com/"

SRC_URI="https://cdn.azul.com/zulu/bin/zulu${PV}-ca-fx-jdk${BASEVERSION}-linux_x64.tar.gz"

S="${WORKDIR}/zulu${PV}-ca-fx-jdk${BASEVERSION}-linux_x64"

LICENSE="https://www.azul.com/products/core/openjdk-terms-of-use/"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="preserve-libs strip"

QA_PREBUILT="*"

src_compile() { :;}

src_install() {
	HERE="${ED}"/opt/${PN}

	mkdir -p "${HERE}" || die
	cp -rp	"${S}"/* "${HERE}"/ || die
	rm "${HERE}"/src.zip || die
	rm "${HERE}"/jre/lib/amd64/libglassgtk2.so || die
	rm "${HERE}"/jre/lib/amd64/libavplugin* || die
	find "${ED}" -type d -empty -delete || die
}
