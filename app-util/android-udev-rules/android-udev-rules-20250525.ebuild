# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user

DESCRIPTION="Android udev rules list aimed to be the most comprehensive on the net"
HOMEPAGE="https://github.com/M0Rf30/android-udev-rules"

SNAPSHOT=e62577fade0e79a965edfff732b88f228266cb0b
SRC_URI="https://github.com/M0Rf30/android-udev-rules/archive/${SNAPSHOT}.tar.gz -> android-udev-rules-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/android-udev-rules-${SNAPSHOT}"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64"

IUSE="adbusers"

src_prepare() {
	default
	use adbusers || sed -i.bak '/adbusers/d' "51-android.rules"
}

src_install() {
	insinto usr/lib/udev/rules.d
	doins "51-android.rules"

	if use adbusers; then
		insinto usr/lib/sysusers.d
		doins "android-udev.conf"
	fi
}

pkg_preinst() {
	use adbusers && enewgroup adbusers 5037
}
