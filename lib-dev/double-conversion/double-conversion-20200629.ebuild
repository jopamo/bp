# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Binary-decimal and decimal-binary conversion routines for IEEE doubles"
HOMEPAGE="https://github.com/google/double-conversion"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/google/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=b1d531bfb130e7149ffe24bb0f1c5c01f20c3a5f
	SRC_URI="https://github.com/google/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)

	cmake_src_configure
}
