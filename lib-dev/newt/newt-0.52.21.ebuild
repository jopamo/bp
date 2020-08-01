# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Redhat's Newt windowing toolkit development files"
HOMEPAGE="https://pagure.io/newt"
SRC_URI="https://releases.pagure.org/newt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/popt
	lib-dev/slang"

filter-flags -Wl,-z,defs -flto\=\*
