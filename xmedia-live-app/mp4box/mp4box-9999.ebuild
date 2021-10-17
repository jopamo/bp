# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="MP4Box can mux, demux, analyze and manipulate MP4 files like no other tool."
HOMEPAGE="https://gpac.wp.imt.fr/mp4box/"
EGIT_REPO_URI="https://github.com/gpac/gpac.git"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i -e "s/UNKNOWN/$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)/g" "Makefile" || die
}

src_configure() {
	local myconf=(
		--use-zlib=local
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	newbin bin/gcc/MP4Box mp4box

	rm -rf "${ED}"/usr/{include,share}
	rm -f "${ED}"/usr/lib/libgpac_static.a
	rm -rf "${ED}"/usr/lib/pkgconfig
	rm -f "${ED}"/usr/bin/{gpac,MP4Box,MP4Client}
}
