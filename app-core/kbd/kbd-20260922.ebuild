# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy toolchain-funcs

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://kbd-project.org/"
SNAPSHOT=534d71ede7a968b29490e24da73e345791ff3f2c
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
