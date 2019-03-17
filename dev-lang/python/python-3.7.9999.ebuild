# Distributed under the terms of the GNU General Public License v2

EAPI="6"
WANT_LIBTOOL="none"

inherit autotools flag-o-matic python-utils-r1 toolchain-funcs git-r3

DESCRIPTION="An interpreted, interactive, object-oriented programming language"
HOMEPAGE="https://www.python.org/"
EGIT_REPO_URI="https://github.com/python/cpython.git"
EGIT_BRANCH="3.7"

LICENSE="PSF-2"
SLOT="3.7"
KEYWORDS="amd64 arm64"
IUSE="build examples hardened ipv6"
RESTRICT="test"

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

DEPEND="${RDEPEND}
	dev-util/pkgconfig
"
PDEPEND=">=app-eselect/eselect-python-20140125-r1"

PYVER=${SLOT%/*}

src_prepare() {
	# Ensure that internal copies of expat, libffi and zlib are not used.
	rm -fr Modules/expat
	rm -fr Modules/_ctypes/libffi*
	rm -fr Modules/zlib

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
		configure.ac \
		setup.py || die "sed failed to replace @@GENTOO_LIBDIR@@"

	eautoreconf
}

src_configure() {
	local disable

	disable+=" gdbm"
	disable+=" _tkinter"
	export PYTHON_DISABLE_MODULES="${disable}"

	if [[ -n "${PYTHON_DISABLE_MODULES}" ]]; then
		einfo "Disabled modules: ${PYTHON_DISABLE_MODULES}"
	fi

	tc-export CXX

	local myeconfargs=(
		--enable-shared
		$(use_enable ipv6)
		--infodir='${prefix}/share/info'
		--mandir='${prefix}/share/man'
		--with-computed-gotos
		--with-dbmliborder="${dbmliborder}"
		--with-libc=
		--enable-loadable-sqlite-extensions
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
