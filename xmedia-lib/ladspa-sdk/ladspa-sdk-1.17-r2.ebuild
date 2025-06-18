# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

MY_PN=${PN/-/_}
MY_P=${MY_PN}_${PV}

DESCRIPTION="The Linux Audio Developer's Simple Plugin API"
HOMEPAGE="https://www.ladspa.org/"
SRC_URI="https://www.ladspa.org/download/${MY_P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ppc ppc64 ~riscv sparc x86"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${P}-properbuild.patch"
)

src_compile() {
	emake -C src CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		targets
}

src_test() {
	emake -C src test
}

src_install() {
	emake -C src INSTALL_PLUGINS_DIR="/usr/$(get_libdir)/ladspa" \
		DESTDIR="${ED}" \
		MKDIR_P="mkdir -p" \
		install

	dodir /etc/env.d
	echo "LADSPA_PATH=${EPREFIX}/usr/lib/ladspa" > "${ED}/etc/env.d/60ladspa"
}
