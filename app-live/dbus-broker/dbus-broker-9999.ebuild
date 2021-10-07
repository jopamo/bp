# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="https://dbus.freedesktop.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/bus1/dbus-broker"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=ddcbe4c715a42f4c0fdf8e751e1b91861ceb77a4
	SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	#KEYWORDS="amd64 arm64"
fi

LICENSE="|| ( AFL-2.1 GPL-2 )"
SLOT="0"
