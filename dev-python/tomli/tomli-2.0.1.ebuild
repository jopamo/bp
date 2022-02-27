# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=manual

inherit distutils-r1

DESCRIPTION="A lil' TOML parser"
HOMEPAGE="https://pypi.org/project/tomli/
	https://github.com/hukkin/tomli/"
SRC_URI="https://github.com/hukkin/tomli/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://files.pythonhosted.org/packages/py3/${PN::1}/${PN}/${P}-py3-none-any.whl -> ${P}-py3-none-any.whl.zip"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-arch/unzip"

distutils_enable_tests unittest

# do not use any build system to avoid circular deps
python_compile() { :; }

python_test() {
	eunittest -s "${P}"
}

python_install() {
	python_domodule tomli *.dist-info
}
