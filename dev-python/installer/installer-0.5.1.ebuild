# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="A library for installing Python wheels"
HOMEPAGE="
	https://pypi.org/project/installer/
	https://github.com/pypa/installer/
	https://installer.readthedocs.io/en/latest/
"
SRC_URI="
	https://github.com/pypa/installer/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
	https://files.pythonhosted.org/packages/py3/${PN::1}/${PN}/${P%_p*}-py3-none-any.whl
		-> ${P%_p*}-py3-none-any.whl.zip
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-compression/unzip"

python_compile() {
	python_domodule src/installer "${WORKDIR}"/*.dist-info
}
