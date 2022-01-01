# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Synchronous Readline for interactively running to have a conversation with the user via a console(TTY)"
HOMEPAGE="https://github.com/anseki/readline-sync"
EGIT_REPO_URI="https://github.com/anseki/readline-sync"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	rm -f {.gitignore,README*,*.{png,gif}}  || die
}

src_install() {
	local node_modules="${ED}"/usr/lib/node_modules/${PN}
	mkdir -p "${node_modules}" || die
	cp -rp "${S}"/* "${node_modules}"/ || die
}
