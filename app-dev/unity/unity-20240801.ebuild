# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Simple Unit Testing for C"
HOMEPAGE="https://github.com/ThrowTheSwitch/Unity"

SNAPSHOT=c546414657673c9e0bef646ee33e7005d180a85b
SRC_URI="https://github.com/ThrowTheSwitch/Unity/archive/${SNAPSHOT}.tar.gz -> unity-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Unity-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	meson_src_install

	insinto /usr/include/unity
	doins src/unity.c
}
