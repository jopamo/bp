# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="https://github.com/jopamo/lamer"
SNAPSHOT=cd8891ff6fafe5e636860ab590700de8a03ac9f8
SRC_URI="https://github.com/jopamo/lamer/archive/${SNAPSHOT}.tar.gz -> lamer-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lamer-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

DEPEND="
	xgui-app/mpg123
"

src_configure() {
	qa-policy-configure
	local emesonargs=(
		-Dsimd=auto
		-Dsimd-runtime-dispatch=true
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
