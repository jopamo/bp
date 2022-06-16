# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="free and open-source implementation of the Java Platform"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"

SRC_URI="amd64? ( https://cdn.azul.com/zulu/bin/zulu${PV}-ca-jdk17.0.3-linux_x64.tar.gz )
		arm64? ( https://cdn.azul.com/zulu/bin/zulu${PV}-ca-jdk17.0.3-linux_aarch64.tar.gz )"

S="${WORKDIR}/zulu${PV}-ca-jdk17.0.3-linux_x64"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="preserve-libs strip"

QA_PREBUILT="*"

src_compile() { :;}

src_install() {
	HERE="${ED}"/opt/${PN}

	mkdir -p "${HERE}" || die
	cp -rp "${S}"/* "${HERE}"/ || die
	find "${ED}" -type d -empty -delete || die
}
