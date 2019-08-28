# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Git is a fast, scalable, distributed revision control system with a rich command set that provides high-level operations and full access to internals."
HOMEPAGE="http://www.git-scm.com/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/git/git.git"
	EGIT_BRANCH=maint
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=75b2f01a0f642b39b0f29b6218515df9b5eb798e
	SRC_URI="https://github.com/git/git/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="static-libs perl gitweb"

DEPEND="sys-devel/gettext
		app-net/curl
		lib-dev/libpcre2
		lib-dev/expat"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-libpcre2
		--with-curl
		--with-expat
		--without-openssl
		--without-tcltk
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	use static-libs || find "${ED}" -name "*.a" -delete || die

	use perl || rm -rf "${ED}"/usr/share/perl5 || die
	use gitweb || rm -rf "${ED}"/usr/share/gitweb || die

	rm "${ED}"/usr/libexec/git-core/{git-add,git-am,git-annotate,git-apply,git-archive,git-bisect--helper,git-blame,git-branch,git-bundle,git-cat-file,git-check-attr,git-check-ignore,git-check-mailmap,git-checkout,git-checkout-index,git-check-ref-format,git-cherry,git-cherry-pick,git-clean,git-clone,git-column,git-commit,git-commit-graph,git-commit-tree,git-config,git-count-objects,git-credential,git-describe,git-diff,git-diff-files,git-diff-index,git-difftool,git-diff-tree,git-fast-export,git-fetch,git-fetch-pack,git-fmt-merge-msg,git-for-each-ref,git-format-patch,git-fsck,git-fsck-objects,git-gc,git-get-tar-commit-id,git-grep,git-hash-object,git-help,git-index-pack,git-init,git-init-db,git-interpret-trailers,git-log,git-ls-files,git-ls-remote,git-ls-tree,git-mailinfo,git-mailsplit,git-merge,git-merge-base,git-merge-file,git-merge-index,git-merge-ours,git-merge-recursive,git-merge-subtree,git-merge-tree,git-mktag,git-mktree,git-multi-pack-index,git-mv,git-name-rev,git-notes,git-pack-objects,git-pack-redundant,git-pack-refs,git-patch-id,git-prune,git-prune-packed,git-pull,git-push,git-range-diff,git-read-tree,git-rebase,git-receive-pack,git-reflog,git-remote,git-remote-ext,git-remote-fd,git-repack,git-replace,git-rerere,git-reset,git-revert,git-rev-list,git-rev-parse,git-rm,git-send-pack,git-shortlog,git-show,git-show-branch,git-show-index,git-show-ref,git-stage,git-stash,git-status,git-stripspace,git-submodule--helper,git-symbolic-ref,git-tag,git-unpack-file,git-unpack-objects,git-update-index,git-update-ref,git-update-server-info,git-upload-archive,git-upload-pack,git-var,git-verify-commit,git-verify-pack,git-verify-tag,git-whatchanged,git-worktree,git-write-tree}

	for x in git-add git-am git-annotate git-apply git-archive git-bisect--helper git-blame git-branch git-bundle git-cat-file git-check-attr git-check-ignore git-check-mailmap git-checkout git-checkout-index git-check-ref-format git-cherry git-cherry-pick git-clean git-clone git-column git-commit git-commit-graph git-commit-tree git-config git-count-objects git-credential git-describe git-diff git-diff-files git-diff-index git-difftool git-diff-tree git-fast-export git-fetch git-fetch-pack git-fmt-merge-msg git-for-each-ref git-format-patch git-fsck git-fsck-objects git-gc git-get-tar-commit-id git-grep git-hash-object git-help git-index-pack git-init git-init-db git-interpret-trailers git-log git-ls-files git-ls-remote git-ls-tree git-mailinfo git-mailsplit git-merge git-merge-base git-merge-file git-merge-index git-merge-ours git-merge-recursive git-merge-subtree git-merge-tree git-mktag git-mktree git-multi-pack-index git-mv git-name-rev git-notes git-pack-objects git-pack-redundant git-pack-refs git-patch-id git-prune git-prune-packed git-pull git-push git-range-diff git-read-tree git-rebase git-receive-pack git-reflog git-remote git-remote-ext git-remote-fd git-repack git-replace git-rerere git-reset git-revert git-rev-list git-rev-parse git-rm git-send-pack git-shortlog git-show git-show-branch git-show-index git-show-ref git-stage git-stash git-status git-stripspace git-submodule--helper git-symbolic-ref git-tag git-unpack-file git-unpack-objects git-update-index git-update-ref git-update-server-info git-upload-archive git-upload-pack git-var git-verify-commit git-verify-pack git-verify-tag git-whatchanged git-worktree git-write-tree ; do
		dosym git usr/libexec/git-core/${x}
	done
}

