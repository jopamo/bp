# Distributed under the terms of the GNU General Public License v2

inherit multiprocessing toolchain-funcs

DESCRIPTION="Glasgow Haskell Compiler"
HOMEPAGE="https://www.haskell.org/ghc/"

GHC_BOOTSTRAP_VERSION=9.8.2
GHC_BOOTSTRAP_NCURSES=6.6-20261121
HADRIAN_BOOTSTRAP_SOURCES_VERSION=9.8.1
# Keep GHC aligned with the LTS used by Cabal and source-built Hackage closures.
# lockstep-stackage-compiler: true
STACKAGE_SNAPSHOT="lts-24.68"
SRC_URI="
	https://downloads.haskell.org/~ghc/${PV}/${P}-src.tar.xz
	https://downloads.haskell.org/~ghc/${PV}/hadrian-bootstrap-sources/hadrian-bootstrap-sources-${HADRIAN_BOOTSTRAP_SOURCES_VERSION}.tar.gz
	!elibc_musl? (
		https://invisible-mirror.net/archives/ncurses/current/ncurses-${GHC_BOOTSTRAP_NCURSES}.tgz
	)
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
	if use arm64 && use elibc_musl; then
		platform="${arch}-alpine-linux"
	fi
	printf '%s\n' \
		"${WORKDIR}/ghc-${GHC_BOOTSTRAP_VERSION}-${platform}"
}

ghc_build_bootstrap_tinfo() (
	local source="${WORKDIR}/ncurses-${GHC_BOOTSTRAP_NCURSES}"
	local build="${WORKDIR}/ghc-bootstrap-ncurses"

	mkdir -p "${build}" || die
	cd "${build}" || die
	tc-export CC
	# The Debian bindists need a non-threaded libtinfo.so.6 and the
	# NCURSES6_TINFO_* symbol versions derived from the wide-character map.
	"${source}/configure" \
		--with-shared --with-abi-version=6 --enable-widec \
		--with-termlib=tinfo \
		--with-versioned-syms="${source}/package/ncursesw.map" \
		--with-default-terminfo-dir="${EPREFIX}/usr/share/terminfo" \
		--without-cxx --without-cxx-binding --without-ada \
		--without-debug --without-normal --without-progs \
		--without-tests --without-manpages || die
	emake -C include -j1
	emake -C ncurses "../lib/libtinfo.so.${GHC_BOOTSTRAP_NCURSES%%-*}"
)

ghc_bootstrap_terminfo_compat() {
	local compat_dir="${T}/ghc-bootstrap-libs"
	local target curses_target="${EPREFIX}/usr/lib/libncursesw.so.6"

	if ! use elibc_musl; then
		compat_dir="${WORKDIR}/ghc-bootstrap-ncurses/lib"
		[[ -f ${compat_dir}/libtinfo.so.6 ]] || die "missing GHC bootstrap libtinfo"
		ghc_prepend_library_path "${compat_dir}"
		return
	fi

	# GHC uses the terminfo API, linked as libtinfo.so.6 or libncursesw.so.6
	# depending on the bootstrap distribution. bp's threaded ncurses uses
	# libtinfotw.so.6; netbsd-curses provides libterminfo.so.
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
		[[ -e ${curses_target} ]] || curses_target=${target}
		ln -sf "${curses_target}" "${compat_dir}/libncursesw.so.6" || die
		ghc_prepend_library_path "${compat_dir}"
		return
	done

	die "failed to find a terminfo library for the GHC bootstrap compiler"
}

ghc_prepend_library_path() {
	case :${LD_LIBRARY_PATH-}: in
		*:"$1":*) ;;
		*) export LD_LIBRARY_PATH="$1${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" ;;
	esac
}

src_prepare() {
	default

	pushd "$(ghc_bootstrap_dir)" >/dev/null || die
	eapply "${FILESDIR}/ghc-9.8.2-bindist-compiler-flags.patch"
	popd >/dev/null || die
}

src_configure() {
	local bootstrap_dir bootstrap_root bootstrap_sources

	bootstrap_dir=$(ghc_bootstrap_dir)
	bootstrap_root="${T}/ghc-bootstrap"
	if ! use elibc_musl; then
		ghc_build_bootstrap_tinfo
	fi
	ghc_bootstrap_terminfo_compat

	pushd "${bootstrap_dir}" >/dev/null || die
	./configure \
		--prefix="${bootstrap_root}" \
		--disable-ld-override || die
	emake install
	popd >/dev/null || die

	export PATH="${bootstrap_root}/bin:${PATH}"
	LD_BIND_NOW=1 "${bootstrap_root}/bin/ghc" --info >/dev/null ||
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
