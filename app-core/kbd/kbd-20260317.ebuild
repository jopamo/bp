# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy toolchain-funcs

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://kbd-project.org/"
SNAPSHOT=50e3189fb21423964d314a5b21b8b0e6017a7e8d
SRC_URI="https://github.com/1g4-mirror/kbd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"
PATCHES=(
	"${FILESDIR}"/kbd-20260223-flex-extra-type-compat.patch
)

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam test"

RDEPEND="
	pam? ( lib-core/pam )
	app-compression/pigz
"
DEPEND="
	${RDEPEND}
	app-dev/pkgconf
	test? ( lib-dev/check )
"

src_prepare() {
	find . -type f \( -name '*.c' -o -name '*.h' -o -name '*.y' -o -name '*.l' \) -exec sed -i 's/\bstrlcpy\b/strncpy/g' {} + || die
	find . -type f \( -name '*.c' -o -name '*.h' -o -name '*.y' -o -name '*.l' \) -exec sed -i 's/\bstrlcat\b/strncat/g' {} + || die

	default

	if [[ -z ${CHOST} ]]; then
		CHOST="$("$(tc-getCC)" -dumpmachine)" || die
	fi
	export CHOST

	eautoreconf
}

src_configure() {
	qa-policy-configure

	econf \
		--disable-nls \
		$(use_enable pam vlock) \
		$(use_enable test tests)
}

src_install() {
	default
	qa-policy-install
}
