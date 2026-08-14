# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Android SDK build-tools without SDK (apksigner only currently)"
HOMEPAGE="https://developer.android.com/tools/releases/build-tools"
SRC_URI="https://dl.google.com/android/repository/build-tools_r37_linux.zip"

S="${WORKDIR}/android-37.0"

LICENSE="https://developer.android.com/studio/terms"
SLOT="0"
KEYWORDS="amd64"

src_install() {
	exeinto /opt/${PN}
	doexe apksigner

	insinto /opt/${PN}/lib
	doins lib/apksigner.jar

	cat > "${T}"/99${PN} <<- EOF || die
		JAVA_HOME=${EPREFIX}/opt/openjdk8
		PATH=${EPREFIX}/opt/${PN}
		PATH=\$JAVA_HOME/bin:\$PATH
	EOF
	doenvd "${T}"/99${PN}
}
