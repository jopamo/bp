# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Simple Unit Testing for C"
HOMEPAGE="https://github.com/ThrowTheSwitch/Unity"
SNAPSHOT=6502a671d332bde45e19d3b8b674d940c5ff37c0
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
