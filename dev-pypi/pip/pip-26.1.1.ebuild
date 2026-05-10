# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="ssl(+),threads(+)"

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 doins pypi

DESCRIPTION="The PyPA recommended tool for installing Python packages."
HOMEPAGE="https://pip.pypa.io/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b6/48/cb9b7a682f6fe01a4221e1728941dd4ac3cd9090a17db3779d6ff490b602/pip-26.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pip-26.1.1"

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

BDEPEND="
	${RDEPEND}
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"

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
