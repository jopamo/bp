# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a reference implementation of the startup notification protocol"
HOMEPAGE="https://swaywm.org"

SNAPSHOT=07237ff25d6171e1b548118442ddba4259a53ba5
SRC_URI="https://gitlab.freedesktop.org/xdg/startup-notification/-/archive/${SNAPSHOT}/startup-notification-${SNAPSHOT}.tar.bz2 -> startup-notification-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/startup-notification-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
