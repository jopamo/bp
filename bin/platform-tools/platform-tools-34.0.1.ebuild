# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="fastboot and adb"
HOMEPAGE="https://developer.android.com/studio/releases/platform-tools"
SRC_URI="https://dl.google.com/android/repository/platform-tools_r${PV}-linux.zip"

S="${WORKDIR}/${PN}"

LICENSE="https://developer.android.com/studio/terms"
SLOT="0"
KEYWORDS="amd64"

DEPEND="app-live/android-udev-rules"

src_install() {
	exeinto /opt/bin
	doexe {adb,fastboot,mke2fs,make_f2fs,lib64/libc++.so}

	cat > "${T}"/99${PN} <<- EOF || die
		PATH=${EPREFIX}/opt/bin
	EOF
	doenvd "${T}"/99${PN}
}
