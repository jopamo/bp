# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_LIBTOOL="none"

inherit autotools flag-o-matic python-utils-r1 toolchain-funcs

DESCRIPTION="An interpreted, interactive, object-oriented programming language"
HOMEPAGE="https://www.python.org/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/python/cpython.git"
	EGIT_BRANCH="$(ver_cut 1-2)"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=9e209d48cac35108f3955d3f610b6ce60b574ecc
	SRC_URI="https://github.com/python/cpython/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/c${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="PSF-2"
SLOT="$(ver_cut 1-2)"

IUSE="sqlite static test valgrind"

RESTRICT="test"

DEPEND="
	sqlite? ( lib-core/sqlite )
	app-compression/bzip2
	app-compression/xz-utils
	lib-core/libffi
	lib-net/libnsl
	lib-core/gdbm
	virtual/curses
	lib-core/readline
	lib-core/zlib
	sys-devel/gettext
	virtual/ssl
"

BDEPEND="sys-devel/autoconf-archive"

PYVER=${SLOT%/*}

filter-flags -Wl,-z,defs

# large file tests involve a 2.5G file being copied (duplicated)
CHECKREQS_DISK_BUILD=5500M

pkg_pretend() {
	use test && check-reqs_pkg_pretend
}

pkg_setup() {
	use test && check-reqs_pkg_setup
}

src_prepare() {
	# Ensure that internal copies of expat, libffi and zlib are not used.
	rm -fr Modules/expat || die
	rm -fr Modules/_ctypes/libffi* || die
	rm -fr Modules/zlib || die

	default

	# force correct number of jobs
	# https://bugs.gentoo.org/737660
	local jobs=$(makeopts_jobs "${MAKEOPTS}" "$(get_nproc)")
	sed -i -e "s:-j0:-j${jobs}:" Makefile.pre.in || die
	sed -i -e "/self\.parallel/s:True:${jobs}:" setup.py || die

	eautoreconf
}

src_configure() {
	export ax_cv_c_float_words_bigendian=no

	local disable
	export ac_cv_header_bluetooth_bluetooth_h=no
	use sqlite    || disable+=" _sqlite3"
	disable+=" _tkinter"
	export PYTHON_DISABLE_MODULES="${disable}"

	if [[ -n "${PYTHON_DISABLE_MODULES}" ]]; then
		einfo "Disabled modules: ${PYTHON_DISABLE_MODULES}"
	fi

	if [[ "$(gcc-major-version)" -ge 4 ]]; then
		append-flags -fwrapv
	fi

	filter-flags -malign-double

	# Export CXX so it ends up in /usr/lib/python3.X/config/Makefile.
	tc-export CXX

	append-cppflags -I"${ESYSROOT}"/usr/include/ncursesw

	local dbmliborder
	dbmliborder+="${dbmliborder:+:}gdbm"

	local myeconfargs=(
		# glibc-2.30 removes it; since we can't cleanly force-rebuild
		# Python on glibc upgrade, remove it proactively to give
		# a chance for users rebuilding python before glibc
		ac_cv_header_stropts_h=no

		--enable-shared
		--without-static-libpython
		--disable-ipv6
		--infodir='${prefix}/share/info'
		--mandir='${prefix}/share/man'
		--with-computed-gotos
		--with-dbmliborder="${dbmliborder}"
		--with-libc=
		--enable-loadable-sqlite-extensions
		--without-ensurepip
		--with-system-expat
		--with-system-ffi
	)

	OPT="" econf "${myeconfargs[@]}"

	if grep -q "#define POSIX_SEMAPHORES_NOT_ENABLED 1" pyconfig.h; then
		eerror "configure has detected that the sem_open function is broken."
		eerror "Please ensure that /dev/shm is mounted as a tmpfs with mode 1777."
		die "Broken sem_open function (bug 496328)"
	fi
}

src_compile() {
	# Ensure sed works as expected
	# https://bugs.gentoo.org/594768
	local -x LC_ALL=C

	emake CPPFLAGS= CFLAGS= LDFLAGS=
}

src_test() {
	# Skip failing tests.
	local skipped_tests="gdb"

	for test in ${skipped_tests}; do
		mv "${S}"/Lib/test/test_${test}.py "${T}"
	done

	# bug 660358
	local -x COLUMNS=80
	local -x PYTHONDONTWRITEBYTECODE=
	# workaround https://bugs.gentoo.org/775416
	addwrite /usr/lib/python3.10/site-packages

	local jobs=$(makeopts_jobs "${MAKEOPTS}" "$(get_nproc)")

	emake test EXTRATESTOPTS="-u-network -j${jobs}" \
		CPPFLAGS= CFLAGS= LDFLAGS= < /dev/tty
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
	local libdir=${ED}/usr/lib/python${PYVER}

	emake DESTDIR="${D}" altinstall

	sed \
		-e "s/\(CONFIGURE_LDFLAGS=\).*/\1/" \
		-e "s/\(PY_LDFLAGS=\).*/\1/" \
		-i "${libdir}/config-${PYVER}"*/Makefile || die "sed failed"

	# Fix collisions between different slots of Python.
	rm "${ED}/usr/lib/libpython3.so" || die

	# Cheap hack to get version with ABIFLAGS
	local abiver=$(cd "${ED}/usr/include"; echo python*)
	if [[ ${abiver} != python${PYVER} ]]; then
		# Replace python3.X with a symlink to python3.Xm
		rm "${ED}/usr/bin/python${PYVER}" || die
		dosym "${abiver}" "/usr/bin/python${PYVER}"
		# Create python3.X-config symlink
		dosym "${abiver}-config" "/usr/bin/python${PYVER}-config"
		# Create python-3.5m.pc symlink
		dosym "python-${PYVER}.pc" "/usr/lib/pkgconfig/${abiver/${PYVER}/-${PYVER}}.pc"
	fi

	use sqlite || rm -r "${libdir}/"{sqlite3,test/test_sqlite*} || die
	rm -r "${ED}/usr/bin/idle${PYVER}" "${libdir}/"{idlelib,tkinter,test/test_tk*} || die

	insinto /usr/share/gdb/auto-load/usr/lib
	local libname=$(printf 'e:\n\t@echo $(INSTSONAME)\ninclude Makefile\n' | \
		emake --no-print-directory -s -f - 2>/dev/null)
	newins "${S}"/Tools/gdb/libpython.py "${libname}"-gdb.py

	local -x EPYTHON=python${PYVER}
	# if not using a cross-compiler, use the fresh binary
	if ! tc-is-cross-compiler; then
		local -x PYTHON=./python
		local -x LD_LIBRARY_PATH=${LD_LIBRARY_PATH+${LD_LIBRARY_PATH}:}${PWD}
	else
		local -x PYTHON=${EPREFIX}/usr/bin/${EPYTHON}
	fi

	echo "EPYTHON='${EPYTHON}'" > epython.py || die
	python_domodule epython.py

	# python-exec wrapping support
	local pymajor=${PYVER%.*}
	local scriptdir=${D}$(python_get_scriptdir)
	mkdir -p "${scriptdir}" || die
	# python and pythonX
	ln -s "../../../bin/${abiver}" \
		"${scriptdir}/python${pymajor}" || die
	ln -s "python${pymajor}" "${scriptdir}/python" || die
	# python-config and pythonX-config
	# note: we need to create a wrapper rather than symlinking it due
	# to some random dirname(argv[0]) magic performed by python-config
	cat > "${scriptdir}/python${pymajor}-config" <<-EOF || die
		#!/bin/sh
		exec "${abiver}-config" "\${@}"
	EOF
	chmod +x "${scriptdir}/python${pymajor}-config" || die
	ln -s "python${pymajor}-config" \
		"${scriptdir}/python-config" || die
	# 2to3, pydoc
	ln -s "../../../bin/2to3-${PYVER}" \
		"${scriptdir}/2to3" || die
	ln -s "../../../bin/pydoc${PYVER}" \
		"${scriptdir}/pydoc" || die
}
