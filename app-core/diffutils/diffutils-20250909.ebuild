# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=6b9c72607683bcd73d4c5832cf9e94ae979572f0

inherit flag-o-matic

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

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="app-compression/xz-utils"

BDEPEND="app-dev/gperf"

src_prepare() {
	rm -rf gnulib || die
	cp -r "${BROOT}"/usr/share/gnulib gnulib || die

	echo "${PV}" > .tarball-version || die

	NOCONFIGURE=1 \
	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib || die

	default
}

src_configure() {
	use static && append-ldflags -static

	# Disable automagic dependency over libsigsegv; see bug #312351.
	export ac_cv_libsigsegv=no

	econf --disable-nls
}

src_test() {
	# explicitly allow parallel testing
	emake check
}
