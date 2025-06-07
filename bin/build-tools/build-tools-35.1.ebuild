# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Android SDK build-tools without SDK (apksigner only currently)"
HOMEPAGE="https://developer.android.com/tools/releases/build-tools"
SRC_URI="https://dl.google.com/android/repository/build-tools_r$(ver_cut 1)-rc$(ver_cut 2)-linux.zip"

S="${WORKDIR}/android-VanillaIceCream"

LICENSE="https://developer.android.com/studio/terms"
SLOT="0"
KEYWORDS="amd64"

src_install() {
	exeinto /opt/build-tools
	doexe {apksigner,lib/apksigner.jar}

	cat > "${T}"/99build-tools <<- EOF || die
		JAVA_HOME=/opt/openjdk8
		PATH=${EPREFIX}/opt/build-tools
		PATH=$JAVA_HOME/bin:$PATH
	EOF
	doenvd "${T}"/99build-tools
}
