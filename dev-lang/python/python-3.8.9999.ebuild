# Distributed under the terms of the GNU General Public License v2

EAPI=7

WANT_LIBTOOL="none"

inherit flag-o-matic python-utils-r1 toolchain-funcs git-r3

DESCRIPTION="An interpreted, interactive, object-oriented programming language"
HOMEPAGE="https://www.python.org/"
EGIT_REPO_URI="https://github.com/python/cpython.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="PSF-2"
SLOT="$(ver_cut 1).$(ver_cut 2)"
KEYWORDS="amd64 arm64"

IUSE="ipv6 +embed valgrind static"

RESTRICT="test"

DEPEND="!embed? ( lib-sys/sqlite )
		app-compression/bzip2:0=
		app-compression/xz-utils:0=
		>=lib-sys/zlib-1.1.3:0=
		lib-dev/libffi
		sys-devel/gettext
		lib-sys/gdbm
		lib-net/libnsl
		>=lib-sys/ncurses-5.2:0=
		>=lib-sys/readline-4.1:0=
		virtual/ssl
		dev-util/pkgconf
"
PDEPEND=">=app-eselect/eselect-python-20140125-r1"

PYVER=${SLOT%/*}

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	# Ensure that internal copies of expat, libffi and zlib are not used.
	rm -fr Modules/expat
	rm -fr Modules/_ctypes/libffi*
	rm -fr Modules/zlib

	default
}

src_configure() {
	export PYTHON_DISABLE_MODULES="gdbm tkinter _codecs_{hk,tw,cn,jp,kr} ossaudiodev"
	export ax_cv_c_float_words_bigendian=no

	tc-export CXX
	use static && LDFLAGS="-static"
	local myeconfargs=(
		$(usex static --disable-shared --enable-shared)
		$(use_enable ipv6)
		$(use_with valgrind)
		$(usex embed --disable-loadable-sqlite-extensions --enable-loadable-sqlite-extensions)
		--infodir='${prefix}/share/info'
		--mandir='${prefix}/share/man'
		--with-computed-gotos
		--with-dbmliborder="gdbm"
		--with-libc=
		--without-ensurepip
		--with-system-expat
		--with-system-ffi
		--with-lto
	)

	OPT="" econf "${myeconfargs[@]}"
}

src_compile() {
	# Ensure sed works as expected
	# https://bugs.gentoo.org/594768
	local -x LC_ALL=C

	emake CPPFLAGS= CFLAGS= LDFLAGS=
}

src_test() {
	# Tests will not work when cross compiling.
	if tc-is-cross-compiler; then
		elog "Disabling tests due to crosscompiling."
		return
	fi

	# Skip failing tests.
	local skipped_tests="gdb"

	for test in ${skipped_tests}; do
		mv "${S}"/Lib/test/test_${test}.py "${T}"
	done

	# bug 660358
	local -x COLUMNS=80

	local -x PYTHONDONTWRITEBYTECODE=

	emake test EXTRATESTOPTS="-u-network" CPPFLAGS= CFLAGS= LDFLAGS= < /dev/tty
	local result=$?

	for test in ${skipped_tests}; do
		mv "${T}/test_${test}.py" "${S}"/Lib/test
	done

	elog "The following tests have been skipped:"
	for test in ${skipped_tests}; do
		elog "test_${test}.py"
	done

	elog "If you would like to run them, you may:"
	elog "cd '${EPREFIX}/usr/lib/python${PYVER}/test'"
	elog "and run the tests separately."

	if [[ ${result} -ne 0 ]]; then
		die "emake test failed"
	fi
}

src_install() {
	local libdir=${ED%/}/usr/lib/python${PYVER}

	emake DESTDIR="${D}" altinstall

	sed \
		-e "s/\(CONFIGURE_LDFLAGS=\).*/\1/" \
		-e "s/\(PY_LDFLAGS=\).*/\1/" \
		-i "${libdir}/config-${PYVER}"*/Makefile || die "sed failed"

	# Fix collisions between different slots of Python.
	rm -f "${ED%/}/usr/lib/libpython3.so"

	# Cheap hack to get version with ABIFLAGS
	local abiver=$(cd "${ED%/}/usr/include"; echo python*)
	if [[ ${abiver} != python${PYVER} ]]; then
		# Replace python3.X with a symlink to python3.Xm
		rm "${ED%/}/usr/bin/python${PYVER}" || die
		dosym "${abiver}" "/usr/bin/python${PYVER}"
		# Create python3.X-config symlink
		dosym "${abiver}-config" "/usr/bin/python${PYVER}-config"
		# Create python-3.5m.pc symlink
		dosym "python-${PYVER}.pc" "/usr/lib/pkgconfig/${abiver/${PYVER}/-${PYVER}}.pc"
	fi

	insinto /usr/share/gdb/auto-load/usr/lib #443510
	local libname=$(printf 'e:\n\t@echo $(INSTSONAME)\ninclude Makefile\n' | \
		emake --no-print-directory -s -f - 2>/dev/null)
	newins "${S}"/Tools/gdb/libpython.py "${libname}"-gdb.py

	# for python-exec
	local vars=( EPYTHON PYTHON_SITEDIR PYTHON_SCRIPTDIR )

	# if not using a cross-compiler, use the fresh binary
	if ! tc-is-cross-compiler; then
		local -x PYTHON=./python
		local -x LD_LIBRARY_PATH=${LD_LIBRARY_PATH+${LD_LIBRARY_PATH}:}${PWD}
	else
		vars=( PYTHON "${vars[@]}" )
	fi

	python_export "python${PYVER}" "${vars[@]}"
	echo "EPYTHON='${EPYTHON}'" > epython.py || die
	python_domodule epython.py

	# python-exec wrapping support
	local pymajor=${PYVER%.*}
	mkdir -p "${D%/}${PYTHON_SCRIPTDIR}" || die
	# python and pythonX
	ln -s "../../../bin/${abiver}" "${D%/}${PYTHON_SCRIPTDIR}/python${pymajor}" || die
	ln -s "python${pymajor}" "${D%/}${PYTHON_SCRIPTDIR}/python" || die
	# python-config and pythonX-config
	# note: we need to create a wrapper rather than symlinking it due
	# to some random dirname(argv[0]) magic performed by python-config
	cat > "${D%/}${PYTHON_SCRIPTDIR}/python${pymajor}-config" <<-EOF || die
		#!/bin/sh
		exec "${abiver}-config" "\${@}"
	EOF
	chmod +x "${D%/}${PYTHON_SCRIPTDIR}/python${pymajor}-config" || die
	ln -s "python${pymajor}-config" "${D%/}${PYTHON_SCRIPTDIR}/python-config" || die
	# 2to3, pydoc
	ln -s "../../../bin/2to3-${PYVER}" "${D%/}${PYTHON_SCRIPTDIR}/2to3" || die
	ln -s "../../../bin/pydoc${PYVER}" "${D%/}${PYTHON_SCRIPTDIR}/pydoc" || die
}

pkg_preinst() {
	if has_version "<${CATEGORY}/${PN}-${PYVER}" && ! has_version ">=${CATEGORY}/${PN}-${PYVER}_alpha"; then
		python_updater_warning="1"
	fi
}

eselect_python_update() {
	if [[ -z "$(eselect python show)" || ! -f "${EROOT%/}/usr/bin/$(eselect python show)" ]]; then
		eselect python update
	fi

	if [[ -z "$(eselect python show --python${PV%%.*})" || ! -f "${EROOT%/}/usr/bin/$(eselect python show --python${PV%%.*})" ]]; then
		eselect python update --python${PV%%.*}
	fi
}

pkg_postinst() {
	eselect_python_update

	if [[ "${python_updater_warning}" == "1" ]]; then
		ewarn "You have just upgraded from an older version of Python."
		ewarn
		ewarn "Please adjust PYTHON_TARGETS (if so desired), and run emerge with the --newuse or --changed-use option to rebuild packages installing python modules."
	fi
}

pkg_postrm() {
	eselect_python_update
}
