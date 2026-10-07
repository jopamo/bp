# Distributed under the terms of the GNU General Public License v2

# Pinned source-only exports. Set EGIT_REPO_URI and the full EGIT_COMMIT before
# inherit. Packages needing Git history, submodules or LFS use git-r3 instead.

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

SRC_URI="git+${EGIT_REPO_URI}#commit=${EGIT_COMMIT} -> ${PN}-${EGIT_COMMIT}.git-v1.tar.zst"
S="${WORKDIR}/git-source"

BDEPEND+=" app-core/git[curl] app-compression/zstd"

fi
