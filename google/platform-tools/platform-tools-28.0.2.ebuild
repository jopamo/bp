# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="fastboot and adb"
HOMEPAGE="https://developer.android.com/studio/releases/platform-tools"
SRC_URI="https://dl.google.com/android/repository/platform-tools_r${PV}-linux.zip"
S="${WORKDIR}/${PN}"

LICENSE="https://developer.android.com/studio/terms"
SLOT="0/1"
KEYWORDS="amd64"

src_install() {
	dobin {adb,fastboot}
}
