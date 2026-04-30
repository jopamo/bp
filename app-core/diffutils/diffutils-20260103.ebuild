# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=bbc1bdb7719679b16f0fb45f40c83eb71d1f4f87

inherit flag-o-matic qa-policy gl

DESCRIPTION="Tools to make diffs and compare files"
HOMEPAGE="https://www.gnu.org/software/diffutils/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/diffutils"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/diffutils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

SRC_URI+=" ${GL_SRC_URI}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="app-compression/xz-utils"

BDEPEND="
	app-dev/gperf
"

src_prepare() {
	gl_stage_gnulib

	echo "${PV}" > .tarball-version || die

	NOCONFIGURE=1 \
	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib || die

	default
}

src_configure() {
	qa-policy-configure

	use static && append-ldflags -static

	# Disable automagic dependency over libsigsegv; see bug #312351.
	export ac_cv_libsigsegv=no

	econf --disable-nls
}

src_install() {
	default
	qa-policy-install
}

src_test() {
	# explicitly allow parallel testing
	emake check
}
