# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 flag-o-matic

DESCRIPTION="VapourSynth is an library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"
EGIT_REPO_URI="https://github.com/vapoursynth/vapoursynth.git"

LICENSE="LGPL-2.1 OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+vspipe -debug -guard +shared -static-libs"

DEPEND="xgui-misc/zimg"

src_prepare() {
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
