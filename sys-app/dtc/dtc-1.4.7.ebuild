# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Open Firmware device tree compiler"
HOMEPAGE="https://devicetree.org/ https://git.kernel.org/cgit/utils/dtc/dtc.git/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/dtc/dtc.git"
	inherit git-r3
else
	SRC_URI="mirror://kernel/software/utils/${PN}/${P}.tar.xz"
fi

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	sys-devel/bison
	sys-devel/flex
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.4.4-posix-shell.patch
)

src_prepare() {
	default

	sed -i \
		-e '/^CFLAGS =/s:=:+=:' \
		-e '/^CPPFLAGS =/s:=:+=:' \
		-e 's:-Werror::' \
		-e 's:-g -Os::' \
		-e "/^PREFIX =/s:=.*:= ${EPREFIX}/usr:" \
		-e "/^LIBDIR =/s:=.*:= \$(PREFIX)/lib64:" \
		Makefile || die

	tc-export AR CC
	export V=1
}

src_install() {
	default

	use static-libs || find "${ED}" -name '*.a' -delete
}
