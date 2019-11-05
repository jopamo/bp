# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="fastboot and adb"
HOMEPAGE="https://developer.android.com/studio/releases/platform-tools"
SRC_URI="https://dl.google.com/android/repository/platform-tools_r${PV}-linux.zip"
S="${WORKDIR}/${PN}"

LICENSE="https://developer.android.com/studio/terms"
SLOT="0"
KEYWORDS="amd64"

src_install() {
	systemd_dounit "${FILESDIR}/adb.service"
	exeinto /opt/bin
	doexe {adb,fastboot,mke2fs}
}
