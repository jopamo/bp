# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson qa-policy

DESCRIPTION="inih (INI not invented here) simple .INI file parser"
HOMEPAGE="https://github.com/benhoyt/inih"
SNAPSHOT=577ae2dee1f0d9c2d11c7f10375c1715f3d6940c
SRC_URI="https://github.com/benhoyt/inih/archive/${SNAPSHOT}.tar.gz -> inih-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/inih-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"
BDEPEND="app-dev/patchelf"

src_configure() {
	qa-policy-configure

	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
		-Ddistro_install=true
		-Dwith_INIReader=true
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	qa-policy-install
}
