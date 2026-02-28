# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="VapourSynth library for video manipulation"
HOMEPAGE="http://www.vapoursynth.com/"
SNAPSHOT=eddec1a965a0178330112567059537f77b9723a5
SRC_URI="https://github.com/vapoursynth/vapoursynth/archive/${SNAPSHOT}.tar.gz -> vapoursynth-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vapoursynth-${SNAPSHOT}"

LICENSE="LGPL-2.1 OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="vspipe -debug -guard shared -static-libs"

DEPEND="xgui-lib/zimg"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-core
		--disable-python-module
		--enable-vsscript
		$( use_enable shared )
		$( use_enable static-libs static )
		$( use_enable debug )
		$( use_enable guard guard-pattern )
		$( use_enable vspipe )
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
