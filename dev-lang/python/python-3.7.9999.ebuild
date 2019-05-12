# Distributed under the terms of the GNU General Public License v2

EAPI=7

WANT_LIBTOOL="none"

inherit flag-o-matic python-utils-r1 toolchain-funcs git-r3 eutils

DESCRIPTION="An interpreted, interactive, object-oriented programming language"
HOMEPAGE="https://www.python.org/"
EGIT_REPO_URI="https://github.com/python/cpython.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="PSF-2"
SLOT="3.7"
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
		lib-dev/openssl:0=
		dev-util/pkgconf
"
PDEPEND=">=app-eselect/eselect-python-20140125-r1"

PYVER=${SLOT%/*}

replace-flags -Ofast -O2
replace-flags -Wl,-Ofast -Wl,-O2

src_prepare() {
	# Ensure that internal copies of expat, libffi and zlib are not used.
	rm -fr Modules/expat
	rm -fr Modules/_ctypes/libffi*
	rm -fr Modules/zlib

	use embed && epatch ${FILESDIR}/shrink_python.patch

	default
}

src_configure() {
	export PYTHON_DISABLE_MODULES="gdbm tkinter _codecs_{hk,tw,cn,jp,kr} ossaudiodev"

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

src_install() {
	local libdir=${ED}/usr/lib64/python${PYVER}

	emake DESTDIR="${D}" altinstall

	# Fix collisions between different slots of Python.
	rm -f "${ED}usr/lib64/libpython3.so"

	# Cheap hack to get version with ABIFLAGS
	local abiver=$(cd "${ED}usr/include"; echo python*)
	if [[ ${abiver} != python${PYVER} ]]; then
		# Replace python3.X with a symlink to python3.Xm
		rm "${ED}usr/bin/python${PYVER}" || die
		dosym "${abiver}" "/usr/bin/python${PYVER}"
		# Create python3.X-config symlink
		dosym "${abiver}-config" "/usr/bin/python${PYVER}-config"
		# Create python-3.5m.pc symlink
		dosym "python-${PYVER}.pc" "/usr/lib64/pkgconfig/${abiver/${PYVER}/-${PYVER}}.pc"
	fi

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

	python_export "python${PYVER}" "${vars[@]}"
	echo "EPYTHON='${EPYTHON}'" > epython.py || die
	python_domodule epython.py

	# python-exec wrapping support
	local pymajor=${PYVER%.*}
	mkdir -p "${D}${PYTHON_SCRIPTDIR}" || die
	# python and pythonX
	ln -s "../../../bin/${abiver}" \
		"${D}${PYTHON_SCRIPTDIR}/python${pymajor}" || die
	ln -s "python${pymajor}" \
		"${D}${PYTHON_SCRIPTDIR}/python" || die
	# python-config and pythonX-config
	# note: we need to create a wrapper rather than symlinking it due
	# to some random dirname(argv[0]) magic performed by python-config
	cat > "${D}${PYTHON_SCRIPTDIR}/python${pymajor}-config" <<-EOF || die
		#!/bin/sh
		exec "${abiver}-config" "\${@}"
	EOF
	chmod +x "${D}${PYTHON_SCRIPTDIR}/python${pymajor}-config" || die
	ln -s "python${pymajor}-config" \
		"${D}${PYTHON_SCRIPTDIR}/python-config" || die
	# 2to3, pydoc, pyvenv
	ln -s "../../../bin/2to3-${PYVER}" \
		"${D}${PYTHON_SCRIPTDIR}/2to3" || die
	ln -s "../../../bin/pydoc${PYVER}" \
		"${D}${PYTHON_SCRIPTDIR}/pydoc" || die
	ln -s "../../../bin/pyvenv-${PYVER}" \
		"${D}${PYTHON_SCRIPTDIR}/pyvenv" || die
	# idle
}

pkg_preinst() {
	if has_version "<${CATEGORY}/${PN}-${PYVER}" && ! has_version ">=${CATEGORY}/${PN}-${PYVER}_alpha"; then
		python_updater_warning="1"
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

	if [[ "${python_updater_warning}" == "1" ]]; then
		ewarn "You have just upgraded from an older version of Python."
		ewarn
		ewarn "Please adjust PYTHON_TARGETS (if so desired), and run emerge with the --newuse or --changed-use option to rebuild packages installing python modules."
	fi
}

pkg_postrm() {
	eselect_python_update
}
