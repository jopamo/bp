# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="inih (INI not invented here) simple .INI file parser"
HOMEPAGE="https://github.com/benhoyt/inih"
SNAPSHOT=611ab51f8dd7ec583543815b0de693495045fbf8
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
