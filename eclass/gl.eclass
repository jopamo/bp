# @ECLASS: gl.eclass
# @SUPPORTED_EAPIS: 8
# @BLURB: Stage pjo/gl as a build-time gnulib source tree.

if [[ -z ${_GL_ECLASS} ]]; then
	_GL_ECLASS=1

	: "${GL_COMMIT:=bb5fa2c94710d88c4b3e019cf267d2ea0b4a320f}"

	GL_TREE_NAME="gl-${GL_COMMIT}"

	GL_SRC_URI="
		https://gitlab.com/pjo/gl/-/archive/${GL_COMMIT}/gl-${GL_COMMIT}.tar.gz
	"

	gl_stage_gnulib() {
		local target=${1:-gnulib}
		local gl_tree="${WORKDIR}/${GL_TREE_NAME}"
		local relpath

		[[ -d ${gl_tree} ]] || die "missing gl tree: ${gl_tree}"

		rm -rf "${target}" || die
		cp -a "${gl_tree}" "${target}" || die

		for relpath in .gnulib-tool.py gnulib-tool gnulib-tool.py pygnulib; do
			[[ -e ${target}/${relpath} || -L ${target}/${relpath} ]] || die \
				"gl snapshot ${GL_COMMIT} missing ${relpath}; regenerate with sync_gnulib_shared.py"
		done

		rm -rf "${target}/.git" "${target}/.gitmodules" "${target}/.gitignore" || die
	}
fi
