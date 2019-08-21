# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="MP4Box can mux, demux, analyze and manipulate MP4 files like no other tool."
HOMEPAGE="https://gpac.wp.imt.fr/mp4box/"
EGIT_REPO_URI="https://github.com/gpac/gpac.git"

LICENSE="LGPL"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_configure() {
	local myconf=(
		--static-mp4box
		--use-zlib=no
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	dobin bin/gcc/MP4Box
}
