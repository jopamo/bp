# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

SNAPSHOT=ca85d518ab6063ff07af41672dcb366610f51a20

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="~amd64 ~arm64"

RDEPEND="lib-dev/popt"
DEPEND="${RDEPEND}
	dev-util/pkgconf
"

src_configure() {
	tc-export CC
	export CC_FOR_BUILD=$(tc-getBUILD_CC)
	export libdir="/usr/lib"
	unset LIBS # Bug 562004

	if [[ -n ${GCC_SPECS} ]]; then
		# The environment overrides the command line.
		GCC_SPECS+=":${S}/gcc.specs"
	fi
}
