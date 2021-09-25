# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 flag-o-matic

DESCRIPTION="binary diff and patch using the BSDIFF4-format"
HOMEPAGE="http://cx-bsdiff.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
