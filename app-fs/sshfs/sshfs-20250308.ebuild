# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Fuse-filesystem utilizing the sftp service"
HOMEPAGE="https://github.com/libfuse/sshfs"
SNAPSHOT=ccb6821019c19600110af6750e0d2395a9401617
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
	dev-py/docutils"
