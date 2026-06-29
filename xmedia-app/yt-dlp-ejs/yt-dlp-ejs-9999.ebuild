# Distributed under the terms of the GNU General Public License v2

inherit distutils-r1

DISTUTILS_USE_PEP517=hatchling

DESCRIPTION="External JavaScript for yt-dlp supporting many runtimes"
HOMEPAGE="https://github.com/yt-dlp/ejs"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/yt-dlp/ejs"
	inherit git-r3
else
	SNAPSHOT=168e72dcd3e04e0e19e92c012a04b8a1e4658f50
	SRC_URI="https://github.com/yt-dlp/ejs/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/yt-dlp-${SNAPSHOT}
fi

LICENSE="unlicense"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-server/nodejs"

BDEPEND="
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
"

RESTRICT="test network-sandbox"

# hatch-vcs calls setuptools-scm without a dist_name override, so the generic
# pretend-version variable is the reliable one here.
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

python_compile() {
	local npm_home
	npm_home=$(mktemp -d "/tmp/${PF}-${EPYTHON}-npm.XXXXXX") || die

	local -x HOME=${npm_home}
	local -x XDG_CACHE_HOME=${HOME}/.cache
	local -x npm_config_cache=${HOME}/.npm
	local -x npm_config_update_notifier=false

	local ret=0
	distutils-r1_python_compile || ret=${?}

	rm -rf "${npm_home}" || die
	return ${ret}
}
