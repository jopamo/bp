# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs unpacker flag-o-matic

DESCRIPTION="ELF utils that can check files for security relevant properties"
HOMEPAGE="https://wiki.gentoo.org/index.php?title=Project:Hardened/PaX_Utilities"
SRC_URI="mirror://gentoo/${P}.tar.xz
		https://dev.gentoo.org/~vapier/dist/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps debug python seccomp"

DEPEND="caps? ( >=lib-sys/libcap-2.24 )
		python? ( dev-python/pyelftools )
		seccomp? ( lib-sys/libseccomp )
		caps? ( dev-util/pkgconf )
		seccomp? ( dev-util/pkgconf )
		app-compression/xz-utils"

append-flags -fno-strict-aliasing

_emake() {
	emake \
		USE_CAP=$(usex caps) \
		USE_DEBUG=$(usex debug) \
		USE_PYTHON=$(usex python) \
		USE_SECCOMP=$(usex seccomp) \
		"$@"
}

src_configure() {
	tc-export CC PKG_CONFIG
}

src_compile() {
	_emake
}

src_test() {
	_emake check
}

src_install() {
	_emake DESTDIR="${D}" PKGDOCDIR='$(DOCDIR)'/${PF} install
	cleanup_install
}
