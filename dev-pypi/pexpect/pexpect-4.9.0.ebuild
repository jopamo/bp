# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/ptyprocess
"
# lockstep-pypi-deps: end
DESCRIPTION="Pexpect allows easy control of interactive console applications"
HOMEPAGE="
	https://pexpect.readthedocs.io/
	https://github.com/pexpect/pexpect
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/ptyprocess-0.5[${PYTHON_USEDEP}]
"

src_prepare() {
	eapply "${FILESDIR}"/${PN}-4.9.0-py313.patch
	eapply "${FILESDIR}"/${PN}-4.9.0-py314.patch

	distutils-r1_src_prepare
}
