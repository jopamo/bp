# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/setuptools-scm
	dev-pypi/vcs-versioning
"
# lockstep-pypi-deps: end
DESCRIPTION="Core vcs metadata/versioning library used by setuptools-scm"
HOMEPAGE="https://github.com/pypa/setuptools-scm/"
SNAPSHOT=efa2c855307ff1ae4b4e176e53cd5175a2b13f2f
SRC_URI="https://github.com/pypa/setuptools-scm/archive/${SNAPSHOT}.tar.gz -> vcs-versioning-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/setuptools-scm-${SNAPSHOT}/vcs-versioning"

# Keep builds deterministic when building from archive snapshots.
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-py/packaging[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-py/tomli[${PYTHON_USEDEP}]
		dev-py/typing-extensions[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
"
