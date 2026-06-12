# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Fuse-filesystem utilizing the sftp service"
HOMEPAGE="https://github.com/libfuse/sshfs"
SNAPSHOT=8bf7f92cd891073c31857d2ad60df22c04b41820
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
	dev-pypi/docutils"
