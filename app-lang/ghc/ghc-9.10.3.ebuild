# Distributed under the terms of the GNU General Public License v2

inherit multiprocessing toolchain-funcs

DESCRIPTION="Glasgow Haskell Compiler"
HOMEPAGE="https://www.haskell.org/ghc/"

GHC_BOOTSTRAP_VERSION=9.8.2
HADRIAN_BOOTSTRAP_SOURCES_VERSION=9.8.1
# Keep GHC aligned with the LTS used by Cabal and source-built Hackage closures.
# lockstep-stackage-compiler: true
STACKAGE_SNAPSHOT="lts-24.56"
SRC_URI="
	https://downloads.haskell.org/~ghc/${PV}/${P}-src.tar.xz
	https://downloads.haskell.org/~ghc/${PV}/hadrian-bootstrap-sources/hadrian-bootstrap-sources-${HADRIAN_BOOTSTRAP_SOURCES_VERSION}.tar.gz
	amd64? (
		elibc_musl? (
			https://downloads.haskell.org/~ghc/${GHC_BOOTSTRAP_VERSION}/ghc-${GHC_BOOTSTRAP_VERSION}-x86_64-alpine3_12-linux-static-int_native.tar.xz
		)
		!elibc_musl? (
			https://downloads.haskell.org/~ghc/${GHC_BOOTSTRAP_VERSION}/ghc-${GHC_BOOTSTRAP_VERSION}-x86_64-deb12-linux.tar.xz
		)
	)
	arm64? (
		elibc_musl? (
			https://downloads.haskell.org/~ghc/${GHC_BOOTSTRAP_VERSION}/ghc-${GHC_BOOTSTRAP_VERSION}-aarch64-alpine3_18-linux.tar.xz
		)
		!elibc_musl? (
			https://downloads.haskell.org/~ghc/${GHC_BOOTSTRAP_VERSION}/ghc-${GHC_BOOTSTRAP_VERSION}-aarch64-deb11-linux.tar.xz
		)
	)
"
S="${WORKDIR}/${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-util/numactl
	lib-core/gmp
	lib-core/libffi
	virtual/curses
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-build/make
	app-lang/perl
	app-lang/python
"

RESTRICT="strip test"

QA_FLAGS_IGNORED="
	usr/lib/ghc-${PV}/bin/.*
	usr/lib/ghc-${PV}/lib/.*
"

ghc_bootstrap_dir() {
	local arch platform

	if use amd64; then
		arch=x86_64
	elif use arm64; then
		arch=aarch64
	else
		die "unsupported architecture"
	fi
	platform="${arch}-unknown-linux"
	printf '%s\n' \
		"${WORKDIR}/ghc-${GHC_BOOTSTRAP_VERSION}-${platform}"
}

ghc_bootstrap_terminfo_compat() {
	local compat_dir="${T}/ghc-bootstrap-libs"
	local target

	# Upstream bootstrap distributions require the conventional
	# libtinfo.so.6 SONAME. bp's threaded wide-character ncurses uses
	# libtinfotw.so.6 instead; netbsd-curses provides libterminfo.so.
	for target in \
		"${EPREFIX}/usr/lib/libtinfo.so.6" \
		"${EPREFIX}/usr/lib/libtinfotw.so.6" \
		"${EPREFIX}/usr/lib/libtinfow.so.6" \
		"${EPREFIX}/usr/lib/libterminfo.so" \
		"${EPREFIX}/usr/lib/libncursestw.so.6" \
		"${EPREFIX}/usr/lib/libncursesw.so.6" \
		"${EPREFIX}/usr/lib/libncurses.so.6"
	do
		[[ -e ${target} ]] || continue
		mkdir -p "${compat_dir}" || die
		ln -sf "${target}" "${compat_dir}/libtinfo.so.6" || die
		case :${LD_LIBRARY_PATH-}: in
			*:"${compat_dir}":*) ;;
			*) export LD_LIBRARY_PATH="${compat_dir}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" ;;
		esac
		return
	done

	die "failed to find a terminfo library for the GHC bootstrap compiler"
}

src_configure() {
	local bootstrap_dir bootstrap_root bootstrap_sources

	bootstrap_dir=$(ghc_bootstrap_dir)
	bootstrap_root="${T}/ghc-bootstrap"

	pushd "${bootstrap_dir}" >/dev/null || die
	./configure \
		--prefix="${bootstrap_root}" \
		--disable-ld-override || die
	emake install
	popd >/dev/null || die

	export PATH="${bootstrap_root}/bin:${PATH}"
	ghc_bootstrap_terminfo_compat
	"${bootstrap_root}/bin/ghc" --info >/dev/null ||
		die "installed GHC bootstrap compiler is not executable"

	# Upstream's prefetched 9.8.1 archive has the same external sources as the
	# 9.8.2 plan. Replace only its boot-library plan so ARM64 musl can use the
	# first upstream GHC 9.8 seed available for that platform.
	bootstrap_sources="${T}/hadrian-bootstrap-sources-${GHC_BOOTSTRAP_VERSION}"
	mkdir "${bootstrap_sources}" || die
	tar -xzf \
		"${DISTDIR}/hadrian-bootstrap-sources-${HADRIAN_BOOTSTRAP_SOURCES_VERSION}.tar.gz" \
		-C "${bootstrap_sources}" || die
	cp \
		hadrian/bootstrap/plan-bootstrap-${GHC_BOOTSTRAP_VERSION//./_}.json \
		"${bootstrap_sources}/plan-bootstrap.json" || die
	tar -czf "${T}/hadrian-bootstrap-sources.tar.gz" \
		-C "${bootstrap_sources}" . || die

	pushd hadrian/bootstrap >/dev/null || die
	./bootstrap.py \
		-w "${bootstrap_root}/bin/ghc" \
		-s "${T}/hadrian-bootstrap-sources.tar.gz" ||
		die "failed to bootstrap Hadrian"
	popd >/dev/null || die

	tc-export CC CXX LD AR RANLIB
	./configure \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/lib" \
		--disable-ld-override \
		--with-system-libffi \
		--with-ffi-includes="${EPREFIX}/usr/include" ||
		die
}

src_compile() {
	local -a jobs

	ghc_bootstrap_terminfo_compat
	read -r -a jobs <<< "$(get_makeopts_jobs)"
	hadrian/bootstrap/_build/bin/hadrian \
		--flavour="release+no_profiled_libs" \
		--docs=none \
		"${jobs[@]/#/-j}" \
		binary-dist-dir || die
}

src_install() {
	local bindist

	bindist=$(find _build/bindist -mindepth 1 -maxdepth 1 -type d -name "${P}-*" -print -quit)
	[[ -n ${bindist} ]] || die "failed to find GHC binary distribution"

	pushd "${bindist}" >/dev/null || die
	./configure \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/lib" \
		--disable-ld-override || die
	emake DESTDIR="${D}" install
	popd >/dev/null || die
}
