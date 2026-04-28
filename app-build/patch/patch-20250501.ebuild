# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=d161c9a9dbd24bb7e0356e4e07983345777d85aa

inherit flag-o-matic qa-policy gl

DESCRIPTION="Utility to apply diffs to files"
HOMEPAGE="https://www.gnu.org/software/patch/patch.html"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/patch"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/patch/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

SRC_URI+=" ${GL_SRC_URI}"

LICENSE="GPL-3+ patch-man"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test xattr"

COMMON_DEPEND="
	xattr? ( app-core/attr )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"
BDEPEND="
	app-build/autoconf
	app-build/automake
	app-build/bison
	test? ( app-core/bx )
"

src_prepare() {
	gl_stage_gnulib

	printf '%s\n' "${PV}" > .tarball-version || die

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib || die

	default
}

src_configure() {
	use static && append-ldflags -static

	qa-policy-configure
	econf "$(use_enable xattr)"
}

src_test() {
	emake check
}

src_install() {
	default

	qa-policy-install
}
