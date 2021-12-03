# Distributed under the terms of the GNU General Public License v2

EAPI=8

HASH="2a2082e5a09d4267845be086888add4f"

DESCRIPTION="free and open-source implementation of the Java Platform"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"

SRC_URI="amd64? ( https://download.java.net/java/GA/jdk${PV}/${HASH}/12/GPL/openjdk-${PV}_linux-x64_bin.tar.gz )
		arm64? ( https://download.java.net/java/GA/jdk${PV}/${HASH}/12/GPL/openjdk-${PV}_linux-aarch64_bin.tar.gz )"

S="${WORKDIR}/jdk-${PV}"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
KEYWORDS="amd64"

DEPEND="!bin/oracle-jre"

RESTRICT="preserve-libs strip"

QA_PREBUILT="*"

src_compile() { :;}

src_install() {
	mkdir -p "${ED}"/opt/openjdk || die
	cp -rp "${S}"/* "${ED}"/opt/openjdk/ || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die

	cat > "${T}"/99${PN} <<- EOF || die
		PATH=${EPREFIX}/opt/openjdk/bin
		ROOTPATH=${EPREFIX}/opt/openjdk/bin
	EOF
	doenvd "${T}"/99${PN}
}
