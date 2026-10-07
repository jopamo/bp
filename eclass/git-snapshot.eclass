# Distributed under the terms of the GNU General Public License v2

# Pinned source-only exports. Set EGIT_REPO_URI and the full EGIT_COMMIT before
# inherit. Packages needing Git history or LFS use git-r3 instead.
#
# Declare every submodule (including nested ones) at its root-relative path:
# EGIT_SNAPSHOT_SUBMODULES=( "path@full-commit@https://host/repository.git" )
# Corepkg verifies each pin against its parent's gitlink. It never follows
# URLs from .gitmodules.

if [[ -z ${_GIT_SNAPSHOT_ECLASS} ]]; then
_GIT_SNAPSHOT_ECLASS=1

case ${EAPI} in
	8) ;;
	*) die "git-snapshot requires EAPI 8" ;;
esac

[[ ${EGIT_REPO_URI} == https://* ]] ||
	die "git-snapshot requires an HTTPS repository"
[[ ${EGIT_COMMIT} =~ ^([0-9a-f]{40}|[0-9a-f]{64})$ ]] ||
	die "git-snapshot requires a full commit OID"

_git_snapshot_uri="git+${EGIT_REPO_URI}#commit=${EGIT_COMMIT}"
_git_snapshot_format=1
if declare -p EGIT_SNAPSHOT_SUBMODULES &>/dev/null; then
	[[ $(declare -p EGIT_SNAPSHOT_SUBMODULES) == "declare -a "* ]] ||
		die "EGIT_SNAPSHOT_SUBMODULES must be an indexed array"
	for _git_snapshot_submodule in "${EGIT_SNAPSHOT_SUBMODULES[@]}"; do
		[[ ${_git_snapshot_submodule} =~ ^[A-Za-z0-9._/-]+@([0-9a-f]{40}|[0-9a-f]{64})@https://[^[:space:]\&\#]+$ ]] ||
			die "Git snapshot submodule requires path@full-commit@https://repository"
		_git_snapshot_uri+="&submodule=${_git_snapshot_submodule}"
		_git_snapshot_format=2
	done
fi
SRC_URI="${_git_snapshot_uri} -> ${PN}-${EGIT_COMMIT}.git-v${_git_snapshot_format}.tar.zst"
unset _git_snapshot_uri _git_snapshot_format _git_snapshot_submodule
S="${WORKDIR}/git-source"

BDEPEND+=" app-core/git[curl] app-compression/zstd"

fi
