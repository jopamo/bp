# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_OPTIONAL=1

inherit distutils-r1 flag-o-matic qmake-utils toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3 autotools
	EGIT_REPO_URI="git://git.gnupg.org/gpgme.git"
	KEYWORDS="amd64 arm64 x86"
else
	SRC_URI="mirror://gnupg/gpgme/${P}.tar.bz2"
fi

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/related_software/gpgme"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1/11" # subslot = soname major version
IUSE="common-lisp static-libs cxx python qt5"

COMMON_DEPEND=">=app-crypt/gnupg-2
	lib-dev/libassuan
	lib-dev/libgpg-error
	python? ( ${PYTHON_DEPS} )
	qt5? ( gui-lib/qtcore:5 )"

DEPEND="${COMMON_DEPEND}
	python? ( dev-lang/swig )
	qt5? ( gui-lib/qttest:5 )"

RDEPEND="${COMMON_DEPEND}"

do_python() {
	if use python; then
		pushd "lang/python" > /dev/null || die
		top_builddir="../.." srcdir="." CPP=$(tc-getCPP) distutils-r1_src_${EBUILD_PHASE}
		popd > /dev/null
	fi
}

pkg_setup() {
	addpredict /run/user/$(id -u)/gnupg
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local languages=()
	use common-lisp && languages+=( "cl" )
	use cxx && languages+=( "cpp" )
	if use qt5; then
		languages+=( "qt" )
		#use doc ||
		export DOXYGEN=true
		export MOC="$(qt5_get_bindir)/moc"
	fi

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		-enable-languages="${languages[*]}"
		$(use_enable static-libs static)
	)
	econf ${myconf[@]}

	use python && make -C lang/python prepare

	do_python
}

src_compile() {
	default
	do_python
}

src_test() {
	default
	if use python; then
		test_python() {
			emake -C lang/python/tests check \
				PYTHON=${EPYTHON} \
				PYTHONS=${EPYTHON} \
				TESTFLAGS="--python-libdir=${BUILD_DIR}/lib"
		}
		python_foreach_impl test_python
	fi
}

src_install() {
	default
	do_python
	find "${ED}" -name "*.la" -delete || die

	# backward compatibility for gentoo
	# in the past we had slots
	dodir /usr/include/gpgme
	dosym ../gpgme.h /usr/include/gpgme/gpgme.h
}
