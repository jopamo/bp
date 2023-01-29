# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="A common interface to Gentoo package managers"
HOMEPAGE="https://github.com/mgorny/gentoopm/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/mgorny/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=f5c1d10d15ffbb490730eca5ef69dce379313cc6
	SRC_URI="https://github.com/mgorny/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

python_test() {
	esetup.py test
}
