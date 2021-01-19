# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Headers from glibc for musl use"
EGIT_REPO_URI="https://github.com/bminor/glibc.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="arm64 amd64"

src_prepare() {
	default
	rm *
}

src_install() {
	insinto usr/include/sys/
	doins include/sys/cdefs.h
	doins include/sys/queue.h
	doins include/sys/tree.h

	insinto usr/include/
	doins include/error.h
}

install -D "$srcdir"/sys-cdefs.h "$subpkgdir"/usr/include/sys/cdefs.h
		install -D "$srcdir"/sys-queue.h "$subpkgdir"/usr/include/sys/queue.h
		install -D "$srcdir"/sys-tree.h "$subpkgdir"/usr/include/sys/tree.h
