# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 user

DESCRIPTION="Android udev rules list aimed to be the most comprehensive on the net"
HOMEPAGE="https://github.com/M0Rf30/android-udev-rules"
EGIT_REPO_URI="https://github.com/M0Rf30/android-udev-rules"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64"

IUSE="+adbusers"

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
