# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="find cruft files not managed by portage"
HOMEPAGE="https://github.com/vaeth/find_cruft/"
SRC_URI="https://github.com/vaeth/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="dev-lang/perl"

src_install() {
	dobin bin/*

	insinto /usr/lib/find_cruft
	doins -r etc/*
}
