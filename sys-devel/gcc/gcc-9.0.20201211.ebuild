# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT="$(ver_cut 1)-$(ver_cut 3-)"

inherit toolchain

KEYWORDS="amd64 arm64"

SLOT="$(ver_cut 1)"

src_prepare() {
	toolchain_src_prepare
}

src_configure() {
	downgrade_arch_flags
	gcc_do_filter_flags

	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""
	einfo "LDFLAGS=\"${LDFLAGS}\""

	# Force internal zip based jar script to avoid random
	# issues with 3rd party jar implementations.  #384291
	export JAR=no

	local confgcc=( --host=${CHOST} )

	[[ -n ${CBUILD} ]] && confgcc+=( --build=${CBUILD} )

	confgcc+=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib/gcc$(ver_cut 1)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--includedir="${EPREFIX}"/usr/include
		--datadir="${EPREFIX}"/usr/share
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
	)


	confgcc+=( --with-python-dir=${DATAPATH/$PREFIX/}/python )

	local GCC_LANG="c"
	use cxx && GCC_LANG+=",c++"
	use gccgo && GCC_LANG+=",go"
	use lto  && GCC_LANG+=",lto"
	confgcc+=( --enable-languages=${GCC_LANG} )

	### general options

	confgcc+=(
		--disable-obsolete
		--disable-werror
		--with-system-zlib
		--disable-libmudflap
		--enable-default-ssp
		--enable-default-pie
		--enable-lto
		--enable-nls
		--enable-libstdcxx-time
		--disable-multilib
		--disable-rpath
		--enable-threads=posix
		--enable-__cxa_atexit
		--enable-clocale=gnu
		--enable-gnu-unique-object
		--enable-checking=release
		--with-linker-hash-style=gnu
		--enable-gnu-indirect-function
		--enable-linker-build-id
		--disable-libmpx
		--disable-libgcj
		--enable-bootstrap
		--with-build-config="bootstrap-lto-lean"
		--program-suffix=-$(ver_cut 1)
		$(use_with isl)
		$(use_enable openmp libgomp)
		$(use_enable vtv vtable-verify)
		$(use_enable vtv libvtv)
		$(use_enable sanitize libsanitizer)
)

	if use debug ; then
		# The "release" keyword is new to 4.0. #551636
		local off=$(echo release)
		confgcc+=( --enable-checking="${GCC_CHECKS_LIST:-$(usex debug yes ${off})}" )
	fi

	if tc-is-static-only ; then
		confgcc+=( --disable-shared )
	else
		confgcc+=( --enable-shared )
	fi

	### arch options

	use fixed-point && confgcc+=( $(use_enable fixed-point) )

	case $(tc-is-softfloat) in
	yes)    confgcc+=( --with-float=soft ) ;;
	softfp) confgcc+=( --with-float=softfp ) ;;
	*)
		# If they've explicitly opt-ed in, do hardfloat,
		# otherwise let the gcc default kick in.
		case ${CTARGET//_/-} in
		*-hardfloat-*|*eabihf) confgcc+=( --with-float=hard ) ;;
		esac
	esac

	### library options

	if use cilk ; then
		confgcc+=( $(use_enable cilk libcilkrts) )
	fi

	# Disable gcc info regeneration -- it ships with generated info pages
	# already.  Our custom version/urls/etc... trigger it.  #464008
	export gcc_cv_prog_makeinfo_modern=no

	confgcc+=( "$@" ${EXTRA_ECONF} )

	# Nothing wrong with a good dose of verbosity
	echo
	einfo "PREFIX:          ${PREFIX}"
	einfo "BINPATH:         ${BINPATH}"
	einfo "LIBPATH:         ${LIBPATH}"
	einfo "DATAPATH:        ${DATAPATH}"
	echo
	einfo "Languages:       ${GCC_LANG}"
	echo
	einfo "Configuring GCC with: ${confgcc[@]//--/\n\t--}"
	echo

	# Build in a separate build tree
	mkdir -p "${WORKDIR}"/build
	pushd "${WORKDIR}"/build > /dev/null

	# and now to do the actual configuration
	addwrite /dev/zero
	echo "${S}"/configure "${confgcc[@]}"
	# Older gcc versions did not detect bash and re-exec itself, so force the
	# use of bash.  Newer ones will auto-detect, but this is not harmeful.
	CONFIG_SHELL="${EPREFIX}/bin/bash" \
	bash "${S}"/configure "${confgcc[@]}" || die "failed to run configure"

	# return to whatever directory we were in before
	popd > /dev/null
}

src_install() {
	cd "${WORKDIR}"/build

	# Don't allow symlinks in private gcc include dir as this can break the build
	find gcc/include*/ -type l -delete

	# Copy over the info pages.  We disabled their generation earlier, but the
	# build system only expects to install out of the build dir, not the source.  #464008
	mkdir -p gcc/doc
	local x=
	for x in "${S}"/gcc/doc/*.info* ; do
		if [[ -f ${x} ]] ; then
			cp "${x}" gcc/doc/ || die
		fi
	done

	while read x ; do
		grep -q 'It has been auto-edited by fixincludes from' "${x}" \
			&& rm -f "${x}"
	done < <(find gcc/include*/ -name '*.h')

	# Do the 'make install' from the build directory
	S="${WORKDIR}"/build emake -j1 DESTDIR="${D}" install || die

	# Punt some tools which are really only useful while building gcc
	find "${ED}" -name install-tools -prune -type d -exec rm -rf "{}" \;
	# This one comes with binutils
	find "${ED}" -name libiberty.a -delete

	# prune empty dirs left behind
	find "${D}" -depth -type d -delete 2>/dev/null

	exeinto "${DATAPATH#${EPREFIX}}"
	doexe "${FILESDIR}"/c{89,99} || die

	find "${D}${LIBPATH}" \
		'(' \
			-name libstdc++.la -o \
			-name libstdc++fs.la -o \
			-name libsupc++.la -o \
			-name libcc1.la -o \
			-name libcc1plugin.la -o \
			-name libcp1plugin.la -o \
			-name 'libgomp.la' -o \
			-name 'libgomp-plugin-*.la' -o \
			-name libgfortran.la -o \
			-name libgfortranbegin.la -o \
			-name libmpx.la -o \
			-name libmpxwrappers.la -o \
			-name libitm.la -o \
			-name libvtv.la -o \
			-name 'lib*san.la' \
		')' -type f -delete

	# Use gid of 0 because some stupid ports don't have
	# the group 'root' set to gid 0.  Send to /dev/null
	# for people who are testing as non-root.
	chown -R root:0 "${D}${LIBPATH}" 2>/dev/null

	# Installing gdb pretty-printers into gdb-specific location.
	local py gdbdir=/usr/share/gdb/auto-load${LIBPATH}
	pushd "${D}${LIBPATH}" >/dev/null
	for py in $(find . -name '*-gdb.py') ; do
		local multidir=${py%/*}
		insinto "${gdbdir}/${multidir}"
		sed -i "/^libdir =/s:=.*:= '${LIBPATH}/${multidir}':" "${py}" || die #348128
		doins "${py}" || die
		rm "${py}" || die
	done
	popd >/dev/null

	chrpath -d "${ED}"/usr/lib/libstdc++.so*
	cleanup_install
}
