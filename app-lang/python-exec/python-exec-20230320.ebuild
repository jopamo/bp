# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-utils-r1 autotools

DESCRIPTION="Python script wrapper"
HOMEPAGE="https://github.com/mgorny/python-exec/"

SNAPSHOT=eaac6d8ee63d3655a8fda460bda09718fffbcd41
SRC_URI="https://github.com/projg2/python-exec/archive/${SNAPSHOT}.tar.gz -> python-exec-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/python-exec-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS="amd64 arm64"

# Ensure PYTHON_TARGETS is set and is an array
PYTHON_TARGETS=( ${PYTHON_TARGETS} )
[[ ${#PYTHON_TARGETS[@]} -eq 0 ]] && PYTHON_TARGETS=( python3_13 )

IUSE="${PYTHON_TARGETS[@]/#/python_targets_} native-symlinks"

RESTRICT="test"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local pyimpls=() i EPYTHON
	for i in "${PYTHON_TARGETS[@]}"; do
		if use "python_targets_${i}"; then
			python_export "${i}" EPYTHON
			pyimpls+=( "${EPYTHON}" )
		fi
	done

	local myconf=(
		--with-fallback-path="${EPREFIX}/usr/local/sbin:${EPREFIX}/usr/local/bin:${EPREFIX}/usr/sbin:${EPREFIX}/usr/bin:${EPREFIX}/sbin:${EPREFIX}/bin"
		--with-python-impls="${pyimpls[*]}"
	)

	econf "${myconf[@]}"
}

src_install() {
	default

	if use native-symlinks; then
		local programs=( python python3 )
		local scripts=( python-config python3-config 2to3 idle pydoc pyvenv )

		local f
		for f in "${programs[@]}"; do
			# symlink the C wrapper for python to avoid shebang recursion
			# bug #568974
			dosym -r /usr/bin/python-exec2c /usr/bin/"${f}"
		done
		for f in "${scripts[@]}"; do
			# those are python scripts (except for new python-configs)
			# so symlink them via the python wrapper
			dosym -r /usr/lib/python-exec/python-exec2 /usr/bin/"${f}"
		done
	fi
}
