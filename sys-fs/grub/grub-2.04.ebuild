# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic multibuild toolchain-funcs

DESCRIPTION="GNU GRUB boot loader"
HOMEPAGE="https://www.gnu.org/software/grub/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug device-mapper efiemu mount nls static sdl test libzfs"

GRUB_ALL_PLATFORMS=( coreboot efi-32 efi-64 emu ieee1275 loongson multiboot qemu qemu-mips pc uboot xen xen-32 )
IUSE+=" ${GRUB_ALL_PLATFORMS[@]/#/grub_platforms_}"

RDEPEND="
	app-compression/xz-utils
	>=lib-sys/ncurses-5.2-r5:0=
	debug? (
		sdl? ( lib-media/libsdl )
	)
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	libzfs? ( sys-fs/zfs )
	mount? ( =sys-fs/fuse-2.9.9999 )
"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	sys-app/help2man
	sys-devel/texinfo
	grub_platforms_xen? ( app-misc/xen-tools:= )
	grub_platforms_xen-32? ( app-misc/xen-tools:= )
	static? (
		app-compression/xz-utils[static-libs(+)]
	)
	test? (
		sys-app/genromfs
		app-compression/cpio
		app-compression/lzop
		app-misc/qemu
		lib-dev/libisoburn
		sys-app/miscfiles
		sys-app/parted
		sys-fs/squashfs-tools
	)
"
RDEPEND+="
	grub_platforms_efi-32? ( sys-app/efibootmgr )
	grub_platforms_efi-64? ( sys-app/efibootmgr )
	nls? ( sys-devel/gettext )
"

DEPEND+=" !!=lib-media/freetype-2.5.4"

RESTRICT="strip !test? ( test )"

QA_EXECSTACK="usr/bin/grub*-emu* usr/lib/grub/*"
QA_WX_LOAD="usr/lib/grub/*"
QA_MULTILIB_PATHS="usr/lib/grub/.*"

PATCHES=( 	"${FILESDIR}/01_f2b9083f859c7dbf44a7a8e96ee0cf202f9a4187.patch"
			"${FILESDIR}/02_dabdfa1c6a80639197d05f683a445fa8615517fe.patch"
			"${FILESDIR}/03_261df54f170c6d87258eb37ef17d62690720696b.patch"
			"${FILESDIR}/04_688023cd0ac4c985fd0e2ec477fcf1ec33a0e49c.patch"
			"${FILESDIR}/05_15cfd02b74e862bda20626a6e4e2f8a1d201733a.patch"
)

src_prepare() {
	default
	eautoreconf
}

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
		xen*) platform=xen ;;
		guessed) ;;
		*) platform=${MULTIBUILD_VARIANT} ;;
	esac

	case ${MULTIBUILD_VARIANT} in
		*-32)
			if [[ ${CTARGET:-${CHOST}} == x86_64* ]]; then
				local CTARGET=i386
			fi ;;
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
		$(use_enable nls)
		--disable-grub-themes
		--disable-grub-mkfont
		$(use_enable libzfs)
		$(use sdl && use_enable debug grub-emu-sdl)
		${platform:+--with-platform=}${platform}

		# Let configure detect this where supported
		$(usex efiemu '' '--disable-efiemu')
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
	# Sandbox bug 404013.
	use libzfs && addpredict /etc/dfs:/dev/zfs

	grub_do emake
}

src_test() {
	# The qemu dependency is a bit complex.
	# You will need to adjust QEMU_SOFTMMU_TARGETS to match the cpu/platform.
	grub_do emake check
}

src_install() {
	grub_do emake install DESTDIR="${D}"

	insinto /etc/default
	newins "${FILESDIR}"/grub.default-3 grub
}
