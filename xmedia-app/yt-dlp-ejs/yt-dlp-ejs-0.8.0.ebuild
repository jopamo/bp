# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="External JavaScript for yt-dlp supporting many runtimes"
HOMEPAGE="https://github.com/yt-dlp/ejs"

# Track release tags: there is no upstream EJS compatibility branch.
# Coordinate bumps with yt-dlp's EJS_VERSION pin.
SRC_URI="https://github.com/yt-dlp/ejs/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ejs-${PV}"

LICENSE="unlicense MIT ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND+="
	>=app-server/nodejs-22[npm]
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
"

RESTRICT="test network-sandbox"

# hatch-vcs calls setuptools-scm without a dist_name override, so the generic
# pretend-version variable is the reliable one here.
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

python_prepare_all() {
	distutils-r1_python_prepare_all

	# Terser creates no workers when os.cpus() is empty in a restricted builder.
	local jobs=$(makeopts_jobs)
	(( jobs > 0 )) || jobs=1
	sed -i \
		-e "s/terser({/terser({ maxWorkers: ${jobs},/g" \
		-e "s/terser()/terser({ maxWorkers: ${jobs} })/g" \
		rollup.config.js || die
}

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
