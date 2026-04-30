# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Fuse-filesystem utilizing the sftp service"
HOMEPAGE="https://github.com/libfuse/sshfs"
SNAPSHOT=1cd6995713806c3c36d7c006e54d83408006657c
SRC_URI="https://github.com/libfuse/sshfs/archive/${SNAPSHOT}.tar.gz -> sshfs-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sshfs-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-fs/fuse:3
	lib-core/glib
	app-net/openssh"

BDEPEND="app-dev/pkgconf
	dev-py/docutils"
