# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
DESCRIPTION="Core vcs metadata/versioning library used by setuptools-scm"
HOMEPAGE="https://github.com/pypa/setuptools-scm/"
SNAPSHOT=f53cf5c121851998a610822469ae90507006e044
SRC_URI="https://github.com/pypa/setuptools-scm/archive/${SNAPSHOT}.tar.gz -> vcs-versioning-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/setuptools-scm-${SNAPSHOT}/vcs-versioning"

# Keep builds deterministic when building from archive snapshots.
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-pypi/packaging[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-pypi/tomli[${PYTHON_USEDEP}]
		dev-pypi/typing-extensions[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
