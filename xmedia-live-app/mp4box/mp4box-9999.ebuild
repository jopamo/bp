# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="MP4Box can mux, demux, analyze and manipulate MP4 files like no other tool."
HOMEPAGE="https://gpac.wp.imt.fr/mp4box/"
EGIT_REPO_URI="https://github.com/gpac/gpac.git"
EGIT_BRANCH="legacy"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/zlib"

src_prepare() {
	default
	sed -i -e "s/UNKNOWN/$(git log -1 --format="%at" | xargs -I{} date -d @{} +%Y%m%d)/g" "Makefile" || die
}

src_configure() {
	local myconf=(
		--static-mp4box
		--use-zlib
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	newbin bin/gcc/MP4Box mp4box
}
