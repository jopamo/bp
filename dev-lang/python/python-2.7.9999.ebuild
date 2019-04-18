# Distributed under the terms of the GNU General Public License v2

EAPI="6"
WANT_LIBTOOL="none"

inherit autotools flag-o-matic python-utils-r1 toolchain-funcs git-r3

DESCRIPTION="An interpreted, interactive, object-oriented programming language"
HOMEPAGE="https://www.python.org/"
EGIT_REPO_URI="https://github.com/python/cpython.git"
EGIT_BRANCH="2.7"

LICENSE="PSF-2"
SLOT="2.7"
KEYWORDS="amd64 arm64"
IUSE="bluetooth build doc elibc_uclibc examples gdbm ipv6 +ncurses +readline sqlite +ssl +threads tk +wide-unicode wininst +xml"

RDEPEND="app-compression/bzip2:0=
	app-compression/xz-utils:0=
	>=lib-sys/zlib-1.1.3:0=
	lib-dev/libffi
	sys-devel/gettext
	lib-net/libnsl
	>=lib-sys/ncurses-5.2:0=
	>=lib-sys/readline-4.1:0=
	>=lib-sys/sqlite-3.3.8:3=
	lib-dev/openssl:0=
	>=lib-dev/expat-2.1:0=
"

PDEPEND=">=app-eselect/eselect-python-20140125-r1"

src_prepare() {
	# Ensure that internal copies of expat, libffi and zlib are not used.
	rm -r Modules/expat || die
	rm -r Modules/_ctypes/libffi* || die
	rm -r Modules/zlib || die

	if tc-is-cross-compiler; then
		rm "${WORKDIR}/patches/0006-Regenerate-platform-specific-modules.patch" || die
	fi

	local PATCHES=(
		"${FILESDIR}/python-2.7.5-nonfatal-compileall.patch"
		"${FILESDIR}/python-2.7.9-ncurses-pkg-config.patch"
		"${FILESDIR}/python-2.7.10-cross-compile-warn-test.patch"
		"${FILESDIR}/python-2.7.10-system-libffi.patch"
	)

	default

	sed -i -e "s:@@GENTOO_LIBDIR@@:lib64:g" \
		Lib/distutils/command/install.py \
		Lib/distutils/sysconfig.py \
		Lib/site.py \
		Lib/sysconfig.py \
		Lib/test/test_site.py \
		Makefile.pre.in \
		Modules/Setup.dist \
		Modules/getpath.c \
		setup.py || die "sed failed to replace @@GENTOO_LIBDIR@@"

	eautoreconf
}

src_configure() {
		# dbm module can be linked against gdbm.
		# Defaults to gdbm when both are enabled, #204343.
		local disable
		use gdbm || disable+=" dbm"
		disable+=" _bsddb"
		# disable automagic bluetooth headers detection
		use bluetooth || export ac_cv_header_bluetooth_bluetooth_h=no
		use gdbm     || disable+=" gdbm"
		use ncurses  || disable+=" _curses _curses_panel"
		use readline || disable+=" readline"
		use sqlite   || disable+=" _sqlite3"
		use ssl      || export PYTHON_DISABLE_SSL="1"
		use tk       || disable+=" _tkinter"
		use xml      || disable+=" _elementtree pyexpat" # _elementtree uses pyexpat.
		export PYTHON_DISABLE_MODULES="${disable}"

		if ! use xml; then
			ewarn "You have configured Python without XML support."
			ewarn "This is NOT a recommended configuration as you"
			ewarn "may face problems parsing any XML documents."
		fi

	if [[ -n "${PYTHON_DISABLE_MODULES}" ]]; then
		einfo "Disabled modules: ${PYTHON_DISABLE_MODULES}"
	fi

	if [[ "$(gcc-major-version)" -ge 4 ]]; then
		append-flags -fwrapv
	fi

	filter-flags -malign-double

	if tc-is-cross-compiler; then
		# Force some tests that try to poke fs paths.
		export ac_cv_file__dev_ptc=no
		export ac_cv_file__dev_ptmx=yes
	fi

	# Export CXX so it ends up in /usr/lib/python2.X/config/Makefile.
	tc-export CXX
	# The configure script fails to use pkg-config correctly.
	# http://bugs.python.org/issue15506
	export ac_cv_path_PKG_CONFIG=$(tc-getPKG_CONFIG)

	# Set LDFLAGS so we link modules with -lpython2.7 correctly.
	# Needed on FreeBSD unless Python 2.7 is already installed.
	# Please query BSD team before removing this!
	append-ldflags "-L."

	local dbmliborder
	if use gdbm; then
		dbmliborder+="${dbmliborder:+:}gdbm"
	fi

	BUILD_DIR="${WORKDIR}/${CHOST}"
	mkdir -p "${BUILD_DIR}" || die
	cd "${BUILD_DIR}" || die

	ECONF_SOURCE="${S}" OPT="" \
	econf \
		--with-fpectl \
		--enable-shared \
		$(use_enable ipv6) \
		$(use_with threads) \
		$(use wide-unicode && echo "--enable-unicode=ucs4" || echo "--enable-unicode=ucs2") \
		--infodir='${prefix}/share/info' \
		--mandir='${prefix}/share/man' \
		--with-computed-gotos \
		--with-dbmliborder="${dbmliborder}" \
		--with-libc="" \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip

	if use threads && grep -q "#define POSIX_SEMAPHORES_NOT_ENABLED 1" pyconfig.h; then
		eerror "configure has detected that the sem_open function is broken."
		eerror "Please ensure that /dev/shm is mounted as a tmpfs with mode 1777."
		die "Broken sem_open function (bug 496328)"
	fi
}

src_compile() {
	# Avoid invoking pgen for cross-compiles.
	touch Include/graminit.h Python/graminit.c

	cd "${BUILD_DIR}" || die
	emake
}

src_test() {
	# Tests will not work when cross compiling.
	if tc-is-cross-compiler; then
		elog "Disabling tests due to crosscompiling."
		return
	fi

	cd "${BUILD_DIR}" || die

	# Skip failing tests.
	local skipped_tests="distutils gdb"

	for test in ${skipped_tests}; do
		mv "${S}"/Lib/test/test_${test}.py "${T}"
	done

	# Daylight saving time problem
	# https://bugs.python.org/issue22067
	# https://bugs.gentoo.org/610628
	local -x TZ=UTC

	# Rerun failed tests in verbose mode (regrtest -w).
	emake test EXTRATESTOPTS="-w" < /dev/tty
	local result="$?"

	for test in ${skipped_tests}; do
		mv "${T}/test_${test}.py" "${S}"/Lib/test
	done

	elog "The following tests have been skipped:"
	for test in ${skipped_tests}; do
		elog "test_${test}.py"
	done

	elog "If you would like to run them, you may:"
	elog "cd '${EPREFIX}/usr/lib64/python${SLOT}/test'"
	elog "and run the tests separately."

	if [[ "${result}" -ne 0 ]]; then
		die "emake test failed"
	fi
}

src_install() {
	local libdir=${ED}/usr/lib64/python${SLOT}

	cd "${BUILD_DIR}" || die
	emake DESTDIR="${D}" altinstall

	sed -e "s/\(LDFLAGS=\).*/\1/" -i "${libdir}/config/Makefile" || die "sed failed"

	# Fix collisions between different slots of Python.
	mv "${ED}usr/bin/2to3" "${ED}usr/bin/2to3-${SLOT}"
	mv "${ED}usr/bin/pydoc" "${ED}usr/bin/pydoc${SLOT}"
	mv "${ED}usr/bin/idle" "${ED}usr/bin/idle${SLOT}"
	rm -f "${ED}usr/bin/smtpd.py"

	use elibc_uclibc && rm -fr "${libdir}/"{bsddb/test,test}

	insinto /usr/share/gdb/auto-load/usr/lib64 #443510
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

	python_export "python${SLOT}" "${vars[@]}"
	echo "EPYTHON='${EPYTHON}'" > epython.py || die
	python_domodule epython.py

	# python-exec wrapping support
	local pymajor=${SLOT%.*}
	mkdir -p "${D}${PYTHON_SCRIPTDIR}" || die
	# python and pythonX
	ln -s "../../../bin/python${SLOT}" "${D}${PYTHON_SCRIPTDIR}/python${pymajor}" || die
	ln -s "python${pymajor}" "${D}${PYTHON_SCRIPTDIR}/python" || die
	# python-config and pythonX-config
	ln -s "../../../bin/python${SLOT}-config" "${D}${PYTHON_SCRIPTDIR}/python${pymajor}-config" || die
	ln -s "python${pymajor}-config" "${D}${PYTHON_SCRIPTDIR}/python-config" || die
	# 2to3, pydoc, pyvenv
	ln -s "../../../bin/2to3-${SLOT}" "${D}${PYTHON_SCRIPTDIR}/2to3" || die
	ln -s "../../../bin/pydoc${SLOT}" "${D}${PYTHON_SCRIPTDIR}/pydoc" || die
	# idle
	if use tk; then
		ln -s "../../../bin/idle${SLOT}" "${D}${PYTHON_SCRIPTDIR}/idle" || die
	fi
}

eselect_python_update() {
	if [[ -z "$(eselect python show)" || ! -f "${EROOT}usr/bin/$(eselect python show)" ]]; then
		eselect python update
	fi

	if [[ -z "$(eselect python show --python${PV%%.*})" || ! -f "${EROOT}usr/bin/$(eselect python show --python${PV%%.*})" ]]; then
		eselect python update --python${PV%%.*}
	fi
}

pkg_postinst() {
	eselect_python_update
}

pkg_postrm() {
	eselect_python_update
}
