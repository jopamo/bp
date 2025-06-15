# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="A common interface to Gentoo package managers"
HOMEPAGE="https://github.com/mgorny/gentoopm/"

SNAPSHOT=12859b23302269e69b13aaa134881c02e6020e77
SRC_URI="https://github.com/projg2/gentoopm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gentoopm-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

python_test() {
	esetup.py test
}
