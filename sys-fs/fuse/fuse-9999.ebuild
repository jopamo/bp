# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson flag-o-matic git-r3

DESCRIPTION="An interface for filesystems implemented in userspace"
HOMEPAGE="https://github.com/libfuse/libfuse"
EGIT_REPO_URI="https://github.com/libfuse/libfuse.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"

filter-flags -flto\=\*

src_install() {
	meson_src_install
	rm -rf "${ED}"/etc/init.d
}
