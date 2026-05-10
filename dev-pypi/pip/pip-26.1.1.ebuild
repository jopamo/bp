# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="ssl(+),threads(+)"
DISTUTILS_USE_PEP517=flit

inherit distutils-r1 doins pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cachecontrol
	dev-pypi/dependency-groups
	dev-pypi/distlib
	dev-pypi/distro
	dev-pypi/msgpack
	dev-pypi/packaging
	dev-pypi/platformdirs
	dev-pypi/pyproject-hooks
	dev-pypi/requests
	dev-pypi/resolvelib
	dev-pypi/rich
	dev-pypi/setuptools
	dev-pypi/tomli-w
	dev-pypi/truststore
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
DESCRIPTION="The PyPA recommended tool for installing Python packages"
HOMEPAGE="
	https://pip.pypa.io/en/stable/
	https://pypi.org/project/pip/
	https://github.com/pypa/pip/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/cachecontrol-0.14.4[${PYTHON_USEDEP}]
	>=dev-pypi/dependency-groups-1.3.0[${PYTHON_USEDEP}]
	>=dev-pypi/distlib-0.4.0[${PYTHON_USEDEP}]
	>=dev-pypi/distro-1.9.0[${PYTHON_USEDEP}]
	>=dev-pypi/msgpack-1.1.1[${PYTHON_USEDEP}]
	>=dev-pypi/packaging-26.2[${PYTHON_USEDEP}]
	>=dev-pypi/platformdirs-4.3.8[${PYTHON_USEDEP}]
	>=dev-pypi/pyproject-hooks-1.2.0[${PYTHON_USEDEP}]
	>=dev-pypi/requests-2.33.1[${PYTHON_USEDEP}]
	>=dev-pypi/resolvelib-1.2.0[${PYTHON_USEDEP}]
	>=dev-pypi/rich-14.1.0[${PYTHON_USEDEP}]
	>=dev-pypi/setuptools-70.3.0[${PYTHON_USEDEP}]
	>=dev-pypi/tomli-w-1.2.0[${PYTHON_USEDEP}]
	>=dev-pypi/truststore-0.10.1[${PYTHON_USEDEP}]
	>=dev-pypi/typing-extensions-4.13.2[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

python_prepare_all() {
	eapply "${FILESDIR}"/pip-25.0.1-unbundle.patch

	rm -r src/pip/_vendor || die
	find -name '*.py' -exec sed -i \
		-e 's:from pip\\._vendor import:import:g' \
		-e 's:from pip\\._vendor\\.:from :g' \
		{} + || die
	sed -i -e '/_vendor.*\\(COPYING\\|LICENSE\\)/d' pyproject.toml || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	local pipcmd='if True:
		import sys
		sys.argv[0] = "pip"
		__file__ = ""
		from pip._internal.cli.main import main
		sys.exit(main())
	'
	"${EPYTHON}" -c "${pipcmd}" completion --bash > completion.bash || die
	"${EPYTHON}" -c "${pipcmd}" completion --zsh > completion.zsh || die
}

python_install_all() {
	distutils-r1_python_install_all

	newbashcomp completion.bash pip
	insinto /usr/share/zsh/site-functions
	newins completion.zsh _pip
}
