# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 multilib

DESCRIPTION="An FFmpeg based source library and Avisynth/VapourSynth plugin for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"
EGIT_REPO_URI="https://github.com/FFMS/ffms2.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-sys/zlib
	app-media/ffmpeg
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

src_prepare() {
	mkdir -p "${S}/src/config"
	default_src_prepare
	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
