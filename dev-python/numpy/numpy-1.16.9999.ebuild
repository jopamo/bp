# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic multiprocessing toolchain-funcs git-r3

DESCRIPTION="Fast array and numerical python library"
HOMEPAGE="http://www.numpy.org/"
EGIT_REPO_URI="https://github.com/numpy/numpy.git"
EGIT_BRANCH="maintenance/$(ver_cut 1).$(ver_cut 2).x"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="lapack test"

DEPEND="dev-python/cython
	dev-python/setuptools[${PYTHON_USEDEP}]
	lapack? ( dev-util/pkgconf )
	test? ( >=dev-python/nose-1.0[${PYTHON_USEDEP}] )"

pc_incdir() {
	$(tc-getPKG_CONFIG) --cflags-only-I $@ | \
		sed -e 's/^-I//' -e 's/[ ]*-I/:/g' -e 's/[ ]*$//' -e 's|^:||'
}

pc_libdir() {
	$(tc-getPKG_CONFIG) --libs-only-L $@ | \
		sed -e 's/^-L//' -e 's/[ ]*-L/:/g' -e 's/[ ]*$//' -e 's|^:||'
}

pc_libs() {
	$(tc-getPKG_CONFIG) --libs-only-l $@ | \
		sed -e 's/[ ]-l*\(pthread\|m\)\([ ]\|$\)//g' \
		-e 's/^-l//' -e 's/[ ]*-l/,/g' -e 's/[ ]*$//' \
		| tr ',' '\n' | sort -u | tr '\n' ',' | sed -e 's|,$||'
}

python_prepare_all() {
	if use lapack; then
		append-ldflags "$($(tc-getPKG_CONFIG) --libs-only-other cblas lapack)"
		local libdir="${EPREFIX}"/usr/lib64
		cat >> site.cfg <<-EOF || die
			[blas]
			include_dirs = $(pc_incdir cblas)
			library_dirs = $(pc_libdir cblas blas):${libdir}
			blas_libs = $(pc_libs cblas blas)
			[lapack]
			library_dirs = $(pc_libdir lapack):${libdir}
			lapack_libs = $(pc_libs lapack)
		EOF
	else
		export {ATLAS,PTATLAS,BLAS,LAPACK,MKL}=None
	fi

	export CC="$(tc-getCC) ${CFLAGS}"

	append-flags -fno-strict-aliasing

	# See progress in http://projects.scipy.org/scipy/numpy/ticket/573
	# with the subtle difference that we don't want to break Darwin where
	# -shared is not a valid linker argument
	if [[ ${CHOST} != *-darwin* ]]; then
		append-ldflags -shared
	fi

	# don't version f2py, we will handle it.
	sed -i -e '/f2py_exe/s: + os\.path.*$::' numpy/f2py/setup.py || die

	# we don't have f2py-3.3
	sed \
		-e 's:test_f2py:_&:g' \
		-i numpy/tests/test_scripts.py || die

	# QA bug 590464
	# The .py files from numpy/core/tests are just added, instead
	# of being bytecode compiled as a proper subdir package.
	# We trick the buildsystem into accepting it as a bytecode
	# package by adding a setup.py and an empty __init__.py
	#cp numpy/{compat/setup.py,core/tests} || die
	#touch numpy/core/tests/__init__.py || die
	#sed \
	#	-e 's:compat:tests:' \
	#	-i numpy/core/tests/setup.py || die
	#sed \
	#	-e "s:config\.add_data_dir('tests'):config\.add_subpackage('tests'):" \
	#	-i numpy/core/setup.py || die

	distutils-r1_python_prepare_all
}

python_compile() {
	local python_makeopts_jobs=""
	python_is_python3 || python_makeopts_jobs="-j $(makeopts_jobs)"
	distutils-r1_python_compile \
		${python_makeopts_jobs} \
		${NUMPY_FCONFIG}
}

python_test() {
	distutils_install_for_testing --single-version-externally-managed --record "${TMPDIR}/record.txt" ${NUMPY_FCONFIG}

	cd "${TMPDIR}" || die

	${EPYTHON} -c "
	import numpy, sys
	r = numpy.test(label='full', verbose=3)
	sys.exit(0 if r.wasSuccessful() else 1)" || die "Tests fail with ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install ${NUMPY_FCONFIG}
}

python_install_all() {
	distutils-r1_python_install_all
}
