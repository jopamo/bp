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
else
	SNAPSHOT=8da17bb4f7a9a57264792ac9c192440112e85929
	SRC_URI="https://github.com/python/cpython/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/cpython-${SNAPSHOT}
fi

LICENSE="PSF-2"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

IUSE="bluetooth debug libedit ncurses pgo readline sqlite ssl static test tk valgrind +xml"

RESTRICT="test"

DEPEND="
	app-build/gettext
	app-compression/bzip2
	app-compression/xz-utils
	app-lang/python-exec
	lib-core/libffi
	lib-core/zlib
	lib-net/libnsl
	libedit? ( lib-core/libedit )
	ncurses? ( virtual/curses )
	readline? ( lib-core/readline )
	sqlite? ( lib-core/sqlite )
	ssl? ( virtual/ssl )
"

BDEPEND="app-build/autoconf-archive"

PYVER=${SLOT%/*}

SETUPTOOLS_USE_DISTUTILS=local

src_prepare() {
	filter-flags -Wl,-z,defs

	rm -r Modules/expat || die

	default

	# force correct number of jobs
	# https://bugs.gentoo.org/737660
	local jobs=$(makeopts_jobs "${MAKEOPTS}" "$(get_nproc)")
	sed -i -e "s:-j0:-j${jobs}:" Makefile.pre.in || die

	eautoreconf

	sed -i 's/\(PY_VERSION\s*"\)\([^"]*\)+/\1\2/' Include/patchlevel.h || die "sed failed to update PY_VERSION"
}

src_configure() {
	export ax_cv_c_float_words_bigendian=no

	if ! use bluetooth; then
		local -x ac_cv_header_bluetooth_bluetooth_h=no
	fi

	append-flags -fwrapv
	append-flags -ffat-lto-objects
	filter-flags -malign-double

	if use pgo; then
		local profile_task_flags=(
			-m test
			"-j$(makeopts_jobs)"
			--pgo-extended
			-u-network

			# We use a timeout because of how often we've had hang issues
			# here. It also matches the default upstream PROFILE_TASK.
			--timeout 1200

			-x test_gdb
			-x test_dtrace

			# All of these seem to occasionally hang for PGO inconsistently
			# They'll even hang here but be fine in src_test sometimes.
			# bug #828535 (and related: bug #788022)
			-x test_asyncio
			-x test_concurrent_futures
			-x test_httpservers
			-x test_logging
			-x test_multiprocessing_fork
			-x test_socket
			-x test_xmlrpc

			# Hangs (actually runs indefinitely executing itself w/ many cpython builds)
			# bug #900429
			-x test_tools
		)

		if has_version "app-arch/rpm" ; then
			# Avoid sandbox failure (attempts to write to /var/lib/rpm)
			profile_task_flags+=(
				-x test_distutils
			)
		fi
		local -x PROFILE_TASK="${profile_task_flags[*]}"
	fi

	local myeconfargs=(
		--enable-shared
		--without-static-libpython
		--disable-ipv6
		--bindir="${prefix}"/usr/bin
		--infodir='${prefix}/share/info'
		--mandir='${prefix}/share/man'
		--with-computed-gotos
		--with-dbmliborder="${dbmliborder}"
		--with-libc=
		--enable-loadable-sqlite-extensions
		--without-ensurepip
		--with-lto
		--with-system-expat
		--with-platlibdir=lib
		--with-pkg-config=yes
		--with-wheel-pkg-dir="${EPREFIX}"/usr/lib/python/ensurepip
		$(use_with debug assertions)
		$(use_enable pgo optimizations)
		$(use_with readline readline "$(usex libedit editline readline)")
		$(use_with valgrind)
	)

	# Force-disable modules we don't want built.
	# See Modules/Setup for docs on how this works. Setup.local contains our local deviations.
	cat > Modules/Setup.local <<-EOF || die
		*disabled*
		nis
		$(usev !sqlite '_sqlite3')
		$(usev !ssl '_hashlib _ssl')
		$(usev !ncurses '_curses _curses_panel')
		$(usev !readline 'readline')
		$(usev !tk '_tkinter')
	EOF

	# disable implicit optimization/debugging flags
	local -x OPT=

	# pass system CFLAGS & LDFLAGS as _NODIST, otherwise they'll get
	# propagated to sysconfig for built extensions
	local -x CFLAGS_NODIST=${CFLAGS}
	local -x LDFLAGS_NODIST=${LDFLAGS}
	local -x CFLAGS= LDFLAGS=

	econf "${myeconfargs[@]}"

	if grep -q "#define POSIX_SEMAPHORES_NOT_ENABLED 1" pyconfig.h; then
		eerror "configure has detected that the sem_open function is broken."
		eerror "Please ensure that /dev/shm is mounted as a tmpfs with mode 1777."
		die "Broken sem_open function (bug 496328)"
	fi

	# install epython.py as part of stdlib
	echo "EPYTHON='python${PYVER}'" > Lib/epython.py || die
}

src_compile() {
	# Ensure sed works as expected
	# https://bugs.gentoo.org/594768
	local -x LC_ALL=C
	export PYTHONSTRICTEXTENSIONBUILD=1

	# Save PYTHONDONTWRITEBYTECODE so that 'has_version' doesn't
	# end up writing bytecode & violating sandbox.
	# bug #831897
	local -x _PYTHONDONTWRITEBYTECODE=${PYTHONDONTWRITEBYTECODE}

	if use pgo ; then
		# bug 660358
		local -x COLUMNS=80
		local -x PYTHONDONTWRITEBYTECODE=

		addpredict "/usr/lib/python${PYVER}/site-packages"
	fi

	# also need to clear the flags explicitly here or they end up
	# in _sysconfigdata*
	emake CPPFLAGS= CFLAGS= LDFLAGS=

	# Restore saved value from above.
	local -x PYTHONDONTWRITEBYTECODE=${_PYTHONDONTWRITEBYTECODE}
}

src_test() {
	# this just happens to skip test_support.test_freeze that is broken
	# without bundled expat
	# TODO: get a proper skip for it upstream
	local -x LOGNAME=buildbot

	local test_opts=(
		-u-network
		-j "$(makeopts_jobs)"

		# fails
		-x test_concurrent_futures
		-x test_gdb
	)

	# workaround docutils breaking tests
	cat > Lib/docutils.py <<-EOF || die
		raise ImportError("Thou shalt not import!")
	EOF

	local -x COLUMNS=80
	local -x PYTHONDONTWRITEBYTECODE=

	addwrite "/usr/lib/python${PYVER}/site-packages"

	nonfatal emake -Onone test EXTRATESTOPTS="${test_opts[*]}" \
		CPPFLAGS= CFLAGS= LDFLAGS= < /dev/tty
	local ret=${?}

	rm Lib/docutils.py || die

	[[ ${ret} -eq 0 ]] || die "emake test failed"
}

src_install() {
	local libdir=${ED}/usr/lib/python${PYVER}

	# the Makefile rules are broken
	# https://github.com/python/cpython/issues/100221
	mkdir -p "${libdir}"/lib-dynload || die

	# -j1 hack for now for bug #843458
	emake -j1 DESTDIR="${D}" altinstall

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

	if ! use sqlite; then
		rm -r "${libdir}/"sqlite3 || die
	fi
	if ! use tk; then
		rm -r "${ED}/usr/bin/idle${PYVER}" || die
		rm -r "${libdir}/"{idlelib,tkinter,test/test_tk*} || die
	fi

	insinto /usr/share/gdb/auto-load/usr/lib
	local libname=$(
		printf 'e:\n\t@echo $(INSTSONAME)\ninclude Makefile\n' |
		emake --no-print-directory -s -f - 2>/dev/null
	)
	newins Tools/gdb/libpython.py "${libname}"-gdb.py

	# python-exec wrapping support
	local pymajor=${PYVER%.*}
	local EPYTHON=python${PYVER}
	local scriptdir=${D}$(python_get_scriptdir)
	mkdir -p "${scriptdir}" || die
	# python and pythonX
	ln -s "../../../bin/${abiver}" "${scriptdir}/python${pymajor}" || die
	ln -s "python${pymajor}" "${scriptdir}/python" || die
	# python-config and pythonX-config
	# note: we need to create a wrapper rather than symlinking it due
	# to some random dirname(argv[0]) magic performed by python-config
	cat > "${scriptdir}/python${pymajor}-config" <<-EOF || die
		#!/bin/sh
		exec "${abiver}-config" "\${@}"
	EOF
	chmod +x "${scriptdir}/python${pymajor}-config" || die
	ln -s "python${pymajor}-config" "${scriptdir}/python-config" || die
	# 2to3, pydoc
	ln -s "../../../bin/2to3-${PYVER}" "${scriptdir}/2to3" || die
	ln -s "../../../bin/pydoc${PYVER}" "${scriptdir}/pydoc" || die
	# idle
	if use tk; then
		ln -s "../../../bin/idle${PYVER}" "${scriptdir}/idle" || die
	fi
}
