# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Daemon used to register global keyboard shortcuts"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=62c91abe8ca5acd0181553f921560f85c588052a
SRC_URI="https://github.com/lxde/lxqt-globalkeys/archive/${SNAPSHOT}.tar.gz -> lxqt-globalkeys-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-globalkeys-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"

src_install() {
	cmake_src_install
	rm "${ED}"/usr/share/applications/lxqt-config-globalkeyshortcuts.desktop
}
