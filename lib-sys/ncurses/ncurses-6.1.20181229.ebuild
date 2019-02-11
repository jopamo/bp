# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils flag-o-matic toolchain-funcs multilib-minimal versionator

DESCRIPTION="console display library"
HOMEPAGE="http://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"

MY_P="${PN}-$(replace_version_separator 2 -)"
SRC_URI="https://invisible-mirror.net/archives/ncurses/current/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
# The subslot reflects the SONAME.
SLOT="0/6"
KEYWORDS="amd64 arm64"
IUSE="ada +cxx debug doc gpm minimal profile static-libs test threads tinfo trace unicode"

DEPEND="gpm? ( lib-sys/gpm[${MULTILIB_USEDEP}] )"

RDEPEND="${DEPEND}
	!<=lib-sys/ncurses-5.9-r4:5
	!<x11/rxvt-unicode-9.06-r3
	!<x11/st-0.6-r1
	!app-misc/emul-linux-x86-baselibs"

PATCHES=(
	"${FILESDIR}/${PN}-6.0-unified.patch"
)

src_prepare() {
	epatch "${PATCHES[@]}"
	sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in
	eapply_user
}

src_configure() {
	unset TERMINFO #115036
	tc-export_build_env BUILD_{CC,CPP}
	BUILD_CPPFLAGS+=" -D_GNU_SOURCE" #214642

	NCURSES_TARGETS=(
		ncurses
		$(usex unicode 'ncursesw' '')
		$(usex threads 'ncursest' '')
		$(use unicode && usex threads 'ncursestw' '')
	)

	if ! ROOT=/ has_version "~lib-sys/${P}:0" ; then
		local lbuildflags="-static"

		# some toolchains don't quite support static linking
		local dbuildflags="-Wl,-rpath,${WORKDIR}/lib"
		case ${CHOST} in
			*-darwin*)  dbuildflags=     ;;
			*-aix*)     dbuildflags=     ;;
		esac
		echo "int main() {}" | \
			$(tc-getCC) -o x -x c - ${lbuildflags} -pipe >& /dev/null \
			|| lbuildflags="${dbuildflags}"

		# We can't re-use the multilib BUILD_DIR because we run outside of it.
		BUILD_DIR="${WORKDIR}" \
		CHOST=${CBUILD} \
		CFLAGS=${BUILD_CFLAGS} \
		CXXFLAGS=${BUILD_CXXFLAGS} \
		CPPFLAGS=${BUILD_CPPFLAGS} \
		LDFLAGS="${BUILD_LDFLAGS} ${lbuildflags}" \
		do_configure cross --without-shared --with-normal
	fi
	multilib-minimal_src_configure
}

multilib_src_configure() {
	local t
	for t in "${NCURSES_TARGETS[@]}" ; do
		do_configure "${t}"
	done
}

do_configure() {
	local target=$1
	shift

	mkdir "${BUILD_DIR}/${target}"
	cd "${BUILD_DIR}/${target}" || die

	local conf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		$(use_with gpm gpm libgpm.so.1)
		--disable-termcap
		--with-terminfo-dirs="${EPREFIX}/etc/terminfo:${EPREFIX}/usr/share/terminfo"
		--enable-pc-files
		--with-pkg-config="$(tc-getPKG_CONFIG)"
		--with-pkg-config-libdir="${EPREFIX}/usr/$(get_libdir)/pkgconfig"
		--without-normal
		--with-symlinks
		--enable-overwrite
		--with-shared
		--without-debug
		--enable-colorfgbg
		--enable-echo
	)

	if [[ ${target} == ncurses*w ]] ; then
		conf+=( --enable-widec )
	else
		conf+=( --disable-widec )
	fi
	if [[ ${target} == ncursest* ]] ; then
		conf+=( --with-{pthread,reentrant} )
	else
		conf+=( --without-{pthread,reentrant} )
	fi
	# Make sure each variant goes in a unique location.
	if [[ ${target} == "ncurses" ]] ; then
		# "ncurses" variant goes into "${EPREFIX}"/usr/include
		# It is needed on Prefix because the configure script appends
		# "ncurses" to "${prefix}/include" if "${prefix}" is not /usr.
		conf+=( --enable-overwrite )
	else
		conf+=( --includedir="${EPREFIX}"/usr/include/${target} )
	fi
	# See comments in src_configure.
	if [[ ${target} != "cross" ]] ; then
		local cross_path="${WORKDIR}/cross"
		[[ -d ${cross_path} ]] && export TIC_PATH="${cross_path}/progs/tic"
	fi

	CONFIG_SHELL=${EPREFIX}/bin/bash \
	ECONF_SOURCE=${S} \
	econf "${conf[@]}" "$@"
}

src_compile() {
	# See comments in src_configure.
	if ! ROOT=/ has_version "~lib-sys/${P}:0" ; then
		BUILD_DIR="${WORKDIR}" \
		do_compile cross -C progs tic
	fi

	multilib-minimal_src_compile
}

multilib_src_compile() {
	local t
	for t in "${NCURSES_TARGETS[@]}" ; do
		do_compile "${t}"
	done
}

do_compile() {
	local target=$1
	shift

	cd "${BUILD_DIR}/${target}" || die

	emake -j1 sources
	rm -f misc/pc-files
	emake "$@"
}

multilib_src_install() {
	local target
	for target in "${NCURSES_TARGETS[@]}" ; do
		emake -C "${BUILD_DIR}/${target}" DESTDIR="${D}" install
	done

	use static-libs || find "${ED}"/usr/ -name '*.a' -delete

	dosym ../share/terminfo /usr/$(get_libdir)/terminfo
}

multilib_src_install_all() {
		einfo "Installing basic terminfo files in /etc..."
		local x
		for x in ansi console dumb linux rxvt rxvt-unicode screen{,-256color} vt{52,100,102,200,220} \
				 xterm xterm-new xterm-{,256}color
		do
			local termfile=$(find "${ED}"/usr/share/terminfo/ -name "${x}" 2>/dev/null)
			local basedir=$(basename $(dirname "${termfile}"))

			if [[ -n ${termfile} ]] ; then
				dodir /etc/terminfo/${basedir}
				mv ${termfile} "${ED}"/etc/terminfo/${basedir}/
				dosym ../../../../etc/terminfo/${basedir}/${x} \
					/usr/share/terminfo/${basedir}/${x}
			fi
		done

	echo "CONFIG_PROTECT_MASK=\"/etc/terminfo\"" > "${T}"/50ncurses
	doenvd "${T}"/50ncurses

	use minimal && rm -r "${ED}"/usr/share/terminfo*
}
