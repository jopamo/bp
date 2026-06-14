# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=b07cc37ca64fe99260884e7325abc333374e098b

inherit flag-o-matic multibuild toolchain-funcs qa-policy gl

DESCRIPTION="GNU GRUB boot loader"
HOMEPAGE="https://www.gnu.org/software/grub/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/grub"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/grub/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

SRC_URI+=" ${GL_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug device-mapper efi mount static"

GRUB_ALL_PLATFORMS=( efi-64 pc )
IUSE+=" ${GRUB_ALL_PLATFORMS[@]/#/grub_platforms_}"

DEPEND="
	app-core/help2man
	app-build/texinfo
	app-compression/xz-utils
	virtual/curses
	device-mapper? ( >=app-fs/lvm2-2.02.45 )
	mount? ( app-fs/fuse )
	static? ( app-compression/xz-utils[static-libs(+)] )
	grub_platforms_efi-64? ( app-fs/efibootmgr )
"

RESTRICT="strip"

QA_EXECSTACK="usr/lib/grub/*"
QA_WX_LOAD="usr/lib/grub/*"
QA_MULTILIB_PATHS="usr/lib/grub/.*"

grub_do() {
	multibuild_foreach_variant run_in_build_dir "$@"
}

grub_do_once() {
	multibuild_for_best_variant run_in_build_dir "$@"
}

grub_assert_no_rejects() {
	local -a rejects=()
	local reject

	while IFS= read -r -d '' reject; do
		rejects+=( "${reject#${S}/}" )
	done < <(find "${S}" -type f -name '*.rej' -print0)

	[[ ${#rejects[@]} -eq 0 ]] || die "rejected hunks left behind: ${rejects[*]}"
}

grub_configure() {
	local platform target

	case ${MULTIBUILD_VARIANT} in
		efi-64)
			platform=efi
			target=x86_64
			;;
		efi*)
			platform=efi
			;;
		guessed) ;;
		*) platform=${MULTIBUILD_VARIANT} ;;
	esac

	local myconf=(
		--disable-werror
		--program-prefix=
		--libdir="${EPREFIX}"/usr/lib
		$(use_enable debug mm-debug)
		$(use_enable device-mapper)
		$(use_enable mount grub-mount)
		--disable-nls
		--disable-grub-themes
		--disable-grub-mkfont
		--disable-efiemu
	)

	[[ -n ${platform} ]] && myconf+=( --with-platform="${platform}" )
	[[ -n ${target} ]] && myconf+=( --target="${target}" )

	local ECONF_SOURCE="${S}"
	rm -f config.cache || die
	qa-policy-configure
	econf "${myconf[@]}"
}

src_prepare() {
	eapply "${FILESDIR}/bootstrap-skip-applied-patches.patch"
	eapply "${FILESDIR}/fix-gnulib-configh-first.patch"
	eapply "${FILESDIR}/fix-libgcrypt-posix-wrap-implicit-grub-symbols.patch"
	eapply "${FILESDIR}/fix-config-recursive-headers.patch"
	eapply "${FILESDIR}/fix-config-symbol-probes-pie-safe.patch"
	eapply "${FILESDIR}/fix-configure-nopie-detection.patch"
	eapply "${FILESDIR}/fix-build-rules-nopie.patch"
	eapply "${FILESDIR}/fix-bison-api-pure.patch"

	gl_stage_gnulib

	./bootstrap --skip-po --no-git --gnulib-srcdir="${S}/gnulib" || die
	grub_assert_no_rejects

	eapply "${FILESDIR}/fix-gnulib-width.patch"
	eapply "${FILESDIR}/fix-filevercmp-static-assert.patch"
	eapply "${FILESDIR}/fix-gl-extern-inline.patch"
	eapply "${FILESDIR}/fix-config-util-guards.patch"
	eapply "${FILESDIR}/fix-config-util-no-assert-in-freestanding.patch"
	eapply "${FILESDIR}"/fix-musl-dirent-static-assert.patch

	default

	sed -i -e "s/UNKNOWN/${PV}/g" configure || die
}

src_configure() {
	local saved_cflags=${CFLAGS}
	local saved_cppflags=${CPPFLAGS}
	local saved_ldflags=${LDFLAGS}
	local saved_cxxflags=${CXXFLAGS}
	local saved_fflags=${FFLAGS}
	local saved_fcflags=${FCFLAGS}
	local filter_cflags=( -fPIE -fpie -fPIC -fpic -fexceptions -flto\* -fuse-linker-plugin )
	local filter_target_ldflags=( -flto\* -fuse-linker-plugin -pie -static-pie '-Wl,-pie' )
	local filter_host_ldflags=( -flto\* -fuse-linker-plugin )

	filter-flags "${filter_cflags[@]}"
	filter-ldflags "${filter_target_ldflags[@]}"
	local grub_cflags=${CFLAGS}
	local grub_cppflags=${CPPFLAGS}
	local grub_ldflags=${LDFLAGS}

	CFLAGS=${saved_cflags}
	CPPFLAGS=${saved_cppflags}
	LDFLAGS=${saved_ldflags}
	CXXFLAGS=${saved_cxxflags}
	FFLAGS=${saved_fflags}
	FCFLAGS=${saved_fcflags}

	filter-flags "${filter_cflags[@]}"
	filter-ldflags "${filter_host_ldflags[@]}"
	local host_cflags=${CFLAGS}
	local host_cppflags=${CPPFLAGS}
	local host_ldflags=${LDFLAGS}

	CFLAGS=${saved_cflags}
	CPPFLAGS=${saved_cppflags}
	LDFLAGS=${saved_ldflags}
	CXXFLAGS=${saved_cxxflags}
	FFLAGS=${saved_fflags}
	FCFLAGS=${saved_fcflags}

	export HOST_CCASFLAGS=${CCASFLAGS}
	export HOST_CFLAGS=${host_cflags}
	export HOST_CPPFLAGS=${host_cppflags}
	export HOST_LDFLAGS=${host_ldflags}
	export TARGET_CFLAGS=${grub_cflags}
	export TARGET_CPPFLAGS=${grub_cppflags}
	export TARGET_LDFLAGS="${TARGET_LDFLAGS} ${grub_ldflags}"
	unset CCASFLAGS CFLAGS CPPFLAGS LDFLAGS

	use static && HOST_LDFLAGS+=" -static"

	tc-export CC NM OBJCOPY RANLIB STRIP
	tc-export BUILD_CC # Bug 485592

	MULTIBUILD_VARIANTS=()
	local p
	for p in "${GRUB_ALL_PLATFORMS[@]}"; do
		use "grub_platforms_${p}" && MULTIBUILD_VARIANTS+=( "${p}" )
	done
	[[ ${#MULTIBUILD_VARIANTS[@]} -eq 0 ]] && MULTIBUILD_VARIANTS=( guessed )
	grub_do grub_configure
}

src_compile() {
	grub_do emake
}

src_install() {
	grub_do emake install DESTDIR="${D}"

	insinto /etc/default
	newins "${FILESDIR}"/grub.default-3 grub
	qa-policy-install
}
