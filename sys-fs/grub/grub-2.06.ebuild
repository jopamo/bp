# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic multibuild toolchain-funcs

DESCRIPTION="GNU GRUB boot loader"
HOMEPAGE="https://www.gnu.org/software/grub/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug device-mapper efi mount static"

GRUB_ALL_PLATFORMS=( efi-64 pc )
IUSE+=" ${GRUB_ALL_PLATFORMS[@]/#/grub_platforms_}"

DEPEND="
	app-core/help2man
	sys-devel/texinfo
	app-compression/xz-utils
	virtual/curses
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	mount? ( sys-fs/fuse:2 )
	static? ( app-compression/xz-utils[static-libs(+)] )
	grub_platforms_efi-64? ( sys-fs/efibootmgr )
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

grub_configure() {
	local platform

	case ${MULTIBUILD_VARIANT} in
		efi*) platform=efi ;;
		guessed) ;;
		*) platform=${MULTIBUILD_VARIANT} ;;
	esac

	case ${MULTIBUILD_VARIANT} in
		*-64)
			if [[ ${CTARGET:-${CHOST}} == i?86* ]]; then
				local CTARGET=x86_64
				local -x TARGET_CFLAGS="-Os -march=x86-64 ${TARGET_CFLAGS}"
				local -x TARGET_CPPFLAGS="-march=x86-64 ${TARGET_CPPFLAGS}"
			fi ;;
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
		${platform:+--with-platform=}${platform}
		--disable-efiemu
	)

	local ECONF_SOURCE="${S}"
	econf "${myconf[@]}"
}

src_configure() {
	export HOST_CCASFLAGS=${CCASFLAGS}
	export HOST_CFLAGS=${CFLAGS}
	export HOST_CPPFLAGS=${CPPFLAGS}
	export HOST_LDFLAGS=${LDFLAGS}
	unset CCASFLAGS CFLAGS CPPFLAGS LDFLAGS

	use static && HOST_LDFLAGS+=" -static"

	export TARGET_LDFLAGS="${TARGET_LDFLAGS} ${LDFLAGS}"
	unset LDFLAGS

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
}
