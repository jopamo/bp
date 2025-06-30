# Distributed under the terms of the GNU General Public License v2

EAPI=8

BASEVERSION="11.0.27"

DESCRIPTION="Zulu OpenJDK11"
HOMEPAGE="https://www.azul.com/"

SRC_URI="amd64? ( https://cdn.azul.com/zulu/bin/zulu${PV}-ca-fx-jdk${BASEVERSION}-linux_x64.tar.gz )
		arm64? ( https://cdn.azul.com/zulu/bin/zulu${PV}-ca-jdk${BASEVERSION}-linux_aarch64.tar.gz )"

S="${WORKDIR}/zulu${PV}-ca-fx-jdk${BASEVERSION}-linux_x64"

LICENSE="https://www.azul.com/products/core/openjdk-terms-of-use/"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="preserve-libs strip"

QA_PREBUILT="*"

src_compile() { :;}

src_install() {
	HERE="${ED}"/opt/${PN}

	mkdir -p "${HERE}" || die
	cp -rp "${S}"/* "${HERE}"/ || die
	find "${ED}" -type d -empty -delete || die
}
