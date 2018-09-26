# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Wrapper to coreutil's install to preserve Filesystem Extended Attributes"
HOMEPAGE="https://dev.gentoo.org/~blueness/install-xattr/"

inherit toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://anongit.gentoo.org/proj/elfix.git"
	inherit git-r3
else
	SRC_URI="https://dev.gentoo.org/~blueness/install-xattr/${P}.tar.bz2"
	KEYWORDS="amd64 arm64 x86"
	S=${WORKDIR}/${PN}
fi

LICENSE="GPL-3"
SLOT="0"

src_prepare() {
	tc-export CC
	eapply_user
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
