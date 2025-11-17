# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A library for installing Python wheels"
HOMEPAGE="
	https://pypi.org/project/installer/
	https://github.com/pypa/installer/
	https://installer.readthedocs.io/en/latest/
"
SRC_URI+="
	$(pypi_wheel_url --unpack)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-compression/zip-utils
"

distutils_enable_tests pytest

python_compile() {
	python_domodule src/installer "${WORKDIR}"/*.dist-info
}

python_install() {
	distutils-r1_python_install
	python_optimize
}
