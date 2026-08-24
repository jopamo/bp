# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Run a subprocess in a pseudo terminal"
HOMEPAGE="https://github.com/pexpect/ptyprocess"
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/20/e5/16ff212c1e452235a90aeb09066144d0c5a6a8c0834397e03f5224495c4e/ptyprocess-0.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ptyprocess-0.7.0"

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"

src_prepare() {
	default

	# ptyprocess predates PEP 621 and flit-core 4 removed the legacy table.
	cat > pyproject.toml <<-EOF || die
		[build-system]
		requires = ["flit_core >=4"]
		build-backend = "flit_core.buildapi"

		[project]
		name = "ptyprocess"
		version = "${PV}"
		description = "Run a subprocess in a pseudo terminal"
		readme = "README.rst"
		license = "ISC"
		authors = [
		    { name = "Thomas Kluyver", email = "thomas@kluyver.me.uk" },
		]
		classifiers = [
		    "Development Status :: 5 - Production/Stable",
		    "Environment :: Console",
		    "Intended Audience :: Developers",
		    "Intended Audience :: System Administrators",
		    "Operating System :: POSIX",
		    "Operating System :: MacOS :: MacOS X",
		    "Programming Language :: Python",
		    "Programming Language :: Python :: 3",
		    "Topic :: Terminals",
		]
	EOF
}
