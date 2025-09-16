# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Daemon used to register global keyboard shortcuts"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=8d4f8215911e0e9b0aa10a7340d893ca176101b7
SRC_URI="https://github.com/lxqt/lxqt-config/archive/${SNAPSHOT}.tar.gz -> lxqt-config-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-config-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"
