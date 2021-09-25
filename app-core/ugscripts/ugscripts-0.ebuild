# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Misc scripts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="video"

S=${WORKDIR}

src_install() {
	use video && dobin "${FILESDIR}"/video/*
	dosbin "${FILESDIR}"/sbin/*
}
