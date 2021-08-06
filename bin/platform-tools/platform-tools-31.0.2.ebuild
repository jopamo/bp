# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="fastboot and adb"
HOMEPAGE="https://developer.android.com/studio/releases/platform-tools"
SRC_URI="https://dl.google.com/android/repository/platform-tools_r${PV}-linux.zip"

S="${WORKDIR}/${PN}"

LICENSE="https://developer.android.com/studio/terms"
SLOT="0"
KEYWORDS="amd64"

IUSE="systemd"

DEPEND="google/android-udev-rules"

src_install() {
	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/adb.service"
	fi

	exeinto /opt/bin
	doexe {adb,fastboot,mke2fs}

	cat > "${T}"/99${PN} <<- EOF || die
		PATH=${EPREFIX}/opt/bin
		ROOTPATH=${EPREFIX}/opt/bin
	EOF
	doenvd "${T}"/99${PN}
}
