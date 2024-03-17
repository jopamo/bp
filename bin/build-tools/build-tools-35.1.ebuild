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
	exeinto /opt/${PN}
	doexe {apksigner,lib/apksigner.jar}

	cat > "${T}"/99${PN} <<- EOF || die
		PATH=${EPREFIX}/opt/${PN}
	EOF
	doenvd "${T}"/99${PN}
}
