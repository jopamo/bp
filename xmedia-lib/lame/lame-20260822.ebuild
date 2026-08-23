# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="https://github.com/jopamo/lamer"
SNAPSHOT=c4e3e494971fa8a4c71e0b37476c072d723d5769
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
