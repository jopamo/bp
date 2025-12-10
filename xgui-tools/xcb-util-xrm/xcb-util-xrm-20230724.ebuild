# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="XCB utility functions for the X resource manager"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=15c9d4592b82e1b9bb84543644ca959c8361a18c
SRC_URI="https://github.com/jopamo/xcb-util-xrm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
