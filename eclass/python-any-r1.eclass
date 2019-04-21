# Distributed under the terms of the GNU General Public License v2

case "${EAPI:-0}" in
	0|1|2|3|4|5|6|7)
		;;
	*)
		die "Unsupported EAPI=${EAPI} (unknown) for ${ECLASS}"
		;;
esac

if [[ ! ${_PYTHON_ANY_R1} ]]; then

if [[ ${_PYTHON_R1} ]]; then
	die 'python-any-r1.eclass can not be used with python-r1.eclass.'
elif [[ ${_PYTHON_SINGLE_R1} ]]; then
	die 'python-any-r1.eclass can not be used with python-single-r1.eclass.'
fi

inherit python-utils-r1

fi

PYTHON_COMPAT=( python3_7 )

EXPORT_FUNCTIONS pkg_setup

_python_any_set_globals() {
	local usestr deps i PYTHON_PKG_DEP
	[[ ${PYTHON_REQ_USE} ]] && usestr="[${PYTHON_REQ_USE}]"

	_python_set_impls

	for i in "${_PYTHON_SUPPORTED_IMPLS[@]}"; do
		python_export "${i}" PYTHON_PKG_DEP

		# note: need to strip '=' slot operator for || deps
		deps="${PYTHON_PKG_DEP%=} ${deps}"
	done
	deps="|| ( ${deps})"

	if [[ ${PYTHON_DEPS+1} ]]; then
		if [[ ${PYTHON_DEPS} != "${deps}" ]]; then
			eerror "PYTHON_DEPS have changed between inherits (PYTHON_REQ_USE?)!"
			eerror "Before: ${PYTHON_DEPS}"
			eerror "Now   : ${deps}"
			die "PYTHON_DEPS integrity check failed"
		fi
	else
		PYTHON_DEPS=${deps}
		readonly PYTHON_DEPS
	fi
}
_python_any_set_globals
unset -f _python_any_set_globals

if [[ ! ${_PYTHON_ANY_R1} ]]; then

# @FUNCTION: python_gen_any_dep
# @USAGE: <dependency-block>
# @DESCRIPTION:
# Generate an any-of dependency that enforces a version match between
# the Python interpreter and Python packages. <dependency-block> needs
# to list one or more dependencies with verbatim '${PYTHON_USEDEP}'
# references (quoted!) that will get expanded inside the function.
#
# This should be used along with an appropriate python_check_deps()
# that checks which of the any-of blocks were matched.
#
# Example use:
# @CODE
# DEPEND="$(python_gen_any_dep '
#	dev-python/foo[${PYTHON_USEDEP}]
#	|| ( dev-python/bar[${PYTHON_USEDEP}]
#		dev-python/baz[${PYTHON_USEDEP}] )')"
#
# python_check_deps() {
#	has_version "dev-python/foo[${PYTHON_USEDEP}]" \
#		&& { has_version "dev-python/bar[${PYTHON_USEDEP}]" \
#			|| has_version "dev-python/baz[${PYTHON_USEDEP}]"; }
# }
# @CODE
#
# Example value:
# @CODE
# || (
#	(
#		dev-lang/python:2.7
#		dev-python/foo[python_targets_python2_7(-)?,python_single_target_python2_7(+)?]
#		|| ( dev-python/bar[python_targets_python2_7(-)?,python_single_target_python2_7(+)?]
#			dev-python/baz[python_targets_python2_7(-)?,python_single_target_python2_7(+)?] )
#	)
#	(
#		dev-lang/python:3.3
#		dev-python/foo[python_targets_python3_3(-)?,python_single_target_python3_3(+)?]
#		|| ( dev-python/bar[python_targets_python3_3(-)?,python_single_target_python3_3(+)?]
#			dev-python/baz[python_targets_python3_3(-)?,python_single_target_python3_3(+)?] )
#	)
# )
# @CODE
python_gen_any_dep() {
	debug-print-function ${FUNCNAME} "${@}"

	local depstr=${1}
	[[ ${depstr} ]] || die "No dependency string provided"

	local i PYTHON_PKG_DEP out=
	for i in "${_PYTHON_SUPPORTED_IMPLS[@]}"; do
		local PYTHON_USEDEP="python_targets_${i}(-),python_single_target_${i}(+)"
		python_export "${i}" PYTHON_PKG_DEP

		local i_depstr=${depstr//\$\{PYTHON_USEDEP\}/${PYTHON_USEDEP}}
		# note: need to strip '=' slot operator for || deps
		out="( ${PYTHON_PKG_DEP%=} ${i_depstr} ) ${out}"
	done
	echo "|| ( ${out})"
}

# @FUNCTION: _python_EPYTHON_supported
# @USAGE: <epython>
# @INTERNAL
# @DESCRIPTION:
# Check whether the specified implementation is supported by package
# (specified in PYTHON_COMPAT). Calls python_check_deps() if declared.
_python_EPYTHON_supported() {
	debug-print-function ${FUNCNAME} "${@}"

	local EPYTHON=${1}
	local i=${EPYTHON/./_}

	case "${i}" in
		python*|jython*|pypy*)
			;;
		*)
			ewarn "Invalid EPYTHON: ${EPYTHON}"
			return 1
			;;
	esac

	if has "${i}" "${_PYTHON_SUPPORTED_IMPLS[@]}"; then
		if python_is_installed "${i}"; then
			if declare -f python_check_deps >/dev/null; then
				local PYTHON_USEDEP="python_targets_${i}(-),python_single_target_${i}(+)"
				python_check_deps
				return ${?}
			fi

			return 0
		fi
	elif ! has "${i}" "${_PYTHON_ALL_IMPLS[@]}"; then
		ewarn "Invalid EPYTHON: ${EPYTHON}"
	fi
	return 1
}

# @FUNCTION: python_setup
# @DESCRIPTION:
# Determine what the best installed (and supported) Python
# implementation is, and set the Python build environment up for it.
#
# This function will call python_check_deps() if defined.
python_setup() {
	debug-print-function ${FUNCNAME} "${@}"

	# support developer override
	if [[ ${PYTHON_COMPAT_OVERRIDE} ]]; then
		local impls=( ${PYTHON_COMPAT_OVERRIDE} )
		[[ ${#impls[@]} -eq 1 ]] || die "PYTHON_COMPAT_OVERRIDE must name exactly one implementation for python-any-r1"

		ewarn "WARNING: PYTHON_COMPAT_OVERRIDE in effect. The following Python"
		ewarn "implementation will be used:"
		ewarn
		ewarn "	${PYTHON_COMPAT_OVERRIDE}"
		ewarn
		ewarn "Dependencies won't be satisfied, and EPYTHON/eselect-python will be ignored."

		python_export "${impls[0]}" EPYTHON PYTHON
		python_wrapper_setup
		return
	fi

	# first, try ${EPYTHON}... maybe it's good enough for us.
	if [[ ${EPYTHON} ]]; then
		if _python_EPYTHON_supported "${EPYTHON}"; then
			python_export EPYTHON PYTHON
			python_wrapper_setup
			return
		fi
	fi

	# then, try eselect-python
	local variant i
	for variant in '' '--python2' '--python3'; do
		i=$(eselect python --show ${variant} 2>/dev/null)

		if [[ ! ${i} ]]; then
			# no eselect-python?
			break
		elif _python_EPYTHON_supported "${i}"; then
			python_export "${i}" EPYTHON PYTHON
			python_wrapper_setup
			return
		fi
	done

	# fallback to best installed impl.
	# (reverse iteration over _PYTHON_SUPPORTED_IMPLS)
	for (( i = ${#_PYTHON_SUPPORTED_IMPLS[@]} - 1; i >= 0; i-- )); do
		python_export "${_PYTHON_SUPPORTED_IMPLS[i]}" EPYTHON PYTHON
		if _python_EPYTHON_supported "${EPYTHON}"; then
			python_wrapper_setup
			return
		fi
	done

	eerror "No Python implementation found for the build. This is usually"
	eerror "a bug in the ebuild. Please report it to bugs.gentoo.org"
	eerror "along with the build log."
	echo
	die "No supported Python implementation installed."
}

# @FUNCTION: python-any-r1_pkg_setup
# @DESCRIPTION:
# Runs python_setup during from-source installs.
#
# In a binary package installs is a no-op. If you need Python in pkg_*
# phases of a binary package, call python_setup directly.
python-any-r1_pkg_setup() {
	debug-print-function ${FUNCNAME} "${@}"

	[[ ${MERGE_TYPE} != binary ]] && python_setup
}

_PYTHON_ANY_R1=1
fi
