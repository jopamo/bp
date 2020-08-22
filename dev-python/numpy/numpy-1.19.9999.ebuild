# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic git-r3

DESCRIPTION="Fast array and numerical python library"
HOMEPAGE="http://www.numpy.org/"
EGIT_REPO_URI="https://github.com/numpy/numpy.git"
EGIT_BRANCH="maintenance/$(ver_cut 1).$(ver_cut 2).x"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="dev-python/cython
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/nose-1.0[${PYTHON_USEDEP}] )"

BDEPEND="dev-util/pkgconf"

filter-flags -Wl,-z,defs
