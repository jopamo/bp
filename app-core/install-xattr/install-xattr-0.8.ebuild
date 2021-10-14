# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Wrapper to coreutil's install to preserve Filesystem Extended Attributes"
HOMEPAGE="https://dev.gentoo.org/~blueness/install-xattr/"
SRC_URI="https://dev.gentoo.org/~blueness/install-xattr/${P}.tar.bz2"
S=${WORKDIR}/${PN}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	tc-export CC
	append-cppflags "-D_FILE_OFFSET_BITS=64"
}

src_compile() {
	if [[ ${PV} == "9999" ]] ; then
		cd "${WORKDIR}/${P}/misc/${PN}" || die
	fi
	default
}

src_install() {
	if [[ ${PV} == "9999" ]] ; then
		cd "${WORKDIR}/${P}/misc/${PN}" || die
	fi
	DESTDIR=${ED} emake install
}

# We need to fix how tests are done
src_test() {
	true
}
