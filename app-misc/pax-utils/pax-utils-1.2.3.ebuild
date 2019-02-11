# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs unpacker

DESCRIPTION="ELF utils that can check files for security relevant properties"
HOMEPAGE="https://wiki.gentoo.org/index.php?title=Project:Hardened/PaX_Utilities"
SRC_URI="mirror://gentoo/${P}.tar.xz
	https://dev.gentoo.org/~vapier/dist/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps debug python seccomp"

RDEPEND="caps? ( >=lib-sys/libcap-2.24 )
	python? ( dev-python/pyelftools )
	seccomp? ( lib-sys/libseccomp )"
DEPEND="${RDEPEND}
	caps? ( dev-util/pkgconfig )
	seccomp? ( dev-util/pkgconfig )
	app-compression/xz-utils"

_emake() {
	emake \
		USE_CAP=$(usex caps) \
		USE_DEBUG=$(usex debug) \
		USE_PYTHON=$(usex python) \
		USE_SECCOMP=$(usex seccomp) \
		"$@"
}

src_configure() {
	# Avoid slow configure+gnulib+make if on an up-to-date Linux system
	if use prefix || ! use kernel_linux || \
	   has_version '<lib-sys/glibc-2.10'
	then
		econf $(use_with caps) $(use_with debug) $(use_with python) $(use_with seccomp)
	else
		tc-export CC PKG_CONFIG
	fi
}

src_compile() {
	_emake
}

src_test() {
	_emake check
}

src_install() {
	_emake DESTDIR="${D}" PKGDOCDIR='$(DOCDIR)'/${PF} install
}
