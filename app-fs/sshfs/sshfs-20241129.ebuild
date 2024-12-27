# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Fuse-filesystem utilizing the sftp service"
HOMEPAGE="https://github.com/libfuse/sshfs"

SNAPSHOT=ef94977c5abb29254e0647a9c6cfede93c836183
SRC_URI="https://github.com/libfuse/sshfs/archive/${SNAPSHOT}.tar.gz -> sshfs-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sshfs-${SNAPSHOT}"

LICENSE="GPL-2"
KEYWORDS="amd64 arm64"
SLOT="0"

DEPEND="
	app-fs/fuse:3
	lib-util/glib
	app-net/openssh"

BDEPEND="app-dev/pkgconf
	dev-python/docutils"
