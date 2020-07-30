# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Fuse-filesystem utilizing the sftp service"
HOMEPAGE="https://github.com/libfuse/sshfs"
EGIT_REPO_URI="https://github.com/libfuse/sshfs.git"

LICENSE="GPL-2"
KEYWORDS="amd64 arm64"
SLOT="0"

DEPEND="
	sys-fs/fuse:3
	lib-dev/glib
	app-net/openssh"

BDEPEND="dev-util/pkgconf
	dev-python/docutils"
