# Distributed under the terms of the GNU General Public License v2

EAPI=8

SSNAP="8477d996dbc768d5df6aefd89fb61910188434cf"

DESCRIPTION="A tool for reverse engineering Android apk files"
HOMEPAGE="https://apktool.org/"
SRC_URI="amd64? ( https://github.com/iBotPeaches/Apktool/releases/download/v${PV}/${PN}_${PV}.jar
				https://raw.githubusercontent.com/iBotPeaches/Apktool/${SSNAP}/scripts/linux/apktool )"
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="APACHE"
SLOT="0"
KEYWORDS="amd64"

QA_PREBUILT="*"

src_unpack() {
:
}

src_prepare() {
	default
	cp "${DISTDIR}"/* "${WORKDIR}"/
	sed -i 's|libdir="$progdir"|libdir="/opt/apktool"|' apktool
	sed -i '/^libdir="\/opt\/apktool"/a export JAVA_HOME=\/opt\/openjdk8\nexport PATH=$JAVA_HOME\/bin:$PATH' apktool
}

src_install() {
	insinto opt/apktool
	newins apktool_2.9.3.jar apktool.jar

	dobin apktool

}
