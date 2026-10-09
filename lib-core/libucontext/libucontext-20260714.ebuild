# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Implementation of the ucontext API"
HOMEPAGE="https://github.com/kaniini/libucontext"
SNAPSHOT=49e671dd52ff6791295d8161ad3b6da7dc5f6f9d
SRC_URI="https://github.com/kaniini/libucontext/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local emesonargs=(
		-Ddocs=false
		-Dexport_unprefixed=true
		-Dfreestanding=false
		-Dbuild_posix=true
	)
	meson_src_configure
}
