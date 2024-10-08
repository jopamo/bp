# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="base functions required by all Gentoo systems"
HOMEPAGE="https://www.gentoo.org"
SRC_URI="https://github.com/gentoo/${PN}/archive/${P}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	meson_src_install
	insopts -m 0644
	insinto /usr/lib/gentoo/
	doins functions.sh
}
