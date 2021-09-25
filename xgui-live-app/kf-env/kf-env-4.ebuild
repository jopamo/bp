# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Environment setting required for all KDE Frameworks app-misc to run"
HOMEPAGE="https://community.kde.org/Frameworks"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=xgui-live-app/xdg-utils-1.1.1-r1"

S=${WORKDIR}

src_install() {
	einfo "Installing environment file..."

	# higher number to be sure not to kill kde4 env
	local envfile="${T}/78kf"

	echo "CONFIG_PROTECT=${EPREFIX}/usr/share/config" >> ${envfile}
	doenvd ${envfile}
}
