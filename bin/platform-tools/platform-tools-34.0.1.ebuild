# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="fastboot and adb"
HOMEPAGE="https://developer.android.com/studio/releases/platform-tools"
SRC_URI="https://dl.google.com/android/repository/platform-tools_r${PV}-linux.zip"

S="${WORKDIR}/platform-tools"

LICENSE="https://developer.android.com/studio/terms"
SLOT="0"
KEYWORDS="amd64"

DEPEND="app-util/android-udev-rules"

src_install() {
	exeinto /opt/platform-tools
	doexe {adb,fastboot,mke2fs,make_f2fs}

	cat > "${T}"/99platform-tools <<- EOF || die
		PATH=${EPREFIX}/opt/platform-tools
	EOF
	doenvd "${T}"/99platform-tools
}
