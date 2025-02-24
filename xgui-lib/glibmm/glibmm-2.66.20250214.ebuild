# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="the C++ API for GTK"
HOMEPAGE="https://github.com/GNOME/glibmm"

SNAPSHOT=8c8816dec34932751f3f9dd1b44b56eebf2b3ed3
SRC_URI="https://github.com/GNOME/glibmm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/libsigc++"

src_configure() {
	local emesonargs=(
		-Dmaintainer-mode=false
		-Dbuild-deprecated-api=false
		-Dbuild-documentation=false
		-Dbuild-examples=false
		-Dmsvc14x-parallel-installable=false
	)

	meson_src_configure "${emesonargs[@]}"
}
