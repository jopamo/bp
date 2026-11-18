# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Man page generator for scdoc markup"
HOMEPAGE="https://git.sr.ht/~sircmpwn/scdoc"
SRC_URI="https://git.sr.ht/~sircmpwn/scdoc/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

scdoc_emake() {
	local args=()
	if tc-is-cross-compiler; then
		args+=( HOST_SCDOC="${T}/scdoc-build" )
	fi
	emake CC="$(tc-getCC)" PREFIX="${EPREFIX}/usr" "${args[@]}" "$@"
}

src_compile() {
	if tc-is-cross-compiler; then
		emake CC="$(tc-getBUILD_CC)" CFLAGS="${BUILD_CFLAGS}" \
			LDFLAGS="${BUILD_LDFLAGS}" OUTDIR=.build-host scdoc
		mv scdoc "${T}/scdoc-build" || die
	fi
	scdoc_emake
}

src_test() {
	if tc-is-cross-compiler; then
		einfo "Skipping runtime tests for the cross-built scdoc"
		return
	fi
	scdoc_emake check > "${T}/tests.log"
	cat "${T}/tests.log" || die
	# Upstream's test harness prints FAIL without returning failure.
	if grep -qF FAIL "${T}/tests.log"; then
		die "scdoc tests failed"
	fi
}

src_install() {
	scdoc_emake DESTDIR="${D}" install
}
