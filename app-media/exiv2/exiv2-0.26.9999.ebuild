# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit cmake-multilib python-any-r1 git-r3

EGIT_REPO_URI="https://github.com/Exiv2/exiv2.git"
EGIT_BRANCH="0.26"
KEYWORDS="amd64 arm64 x86"

DESCRIPTION="EXIF, IPTC and XMP metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"

LICENSE="GPL-2"
SLOT="0/26"
IUSE="doc examples nls png static-libs webready xmp"

RDEPEND="
	nls? ( >=sys-devel/gettext-0-r1[${MULTILIB_USEDEP}] )
	png? ( >=lib-sys/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )
	webready? (
		lib-net/libssh[${MULTILIB_USEDEP}]
		app-net/curl[${MULTILIB_USEDEP}]
	)
	xmp? ( >=lib-dev/expat-2.1.0-r3[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}
	doc? (
		${PYTHON_DEPS}
		app-text/doxygen
		lib-dev/libxslt
		app-media/graphviz
		dev-util/pkgconfig
	)
	nls? ( sys-devel/gettext )
"

pkg_setup() {
	use doc && python-any-r1_pkg_setup
}

src_prepare() {
	if [[ ${PV} != *9999 ]] ; then
		if [[ -d po ]] ; then
			pushd po > /dev/null || die
			local lang
			for lang in *.po; do
				if [[ -e ${lang} ]] \
						&& ! has ${lang/.po/} ${LINGUAS-${lang/.po/}} ; then
					case ${lang} in
						CMakeLists.txt | \
						${PN}.pot)      ;;
						*) rm -r ${lang} || die ;;
					esac
				fi
			done
			popd > /dev/null || die
		else
			die "Failed to prepare LINGUAS - po directory moved?"
		fi
	fi

	# FIXME @upstream:
	einfo "Converting doc/cmd.txt to UTF-8"
	iconv -f LATIN1 -t UTF-8 doc/cmd.txt > doc/cmd.txt.tmp || die
	mv -f doc/cmd.txt.tmp doc/cmd.txt || die

	if use doc; then
		einfo "Updating doxygen config"
		doxygen &>/dev/null -u config/Doxyfile || die
	fi

	cmake-utils_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=(
		-DEXIV2_ENABLE_BUILD_SAMPLES=NO
		-DEXIV2_ENABLE_BUILD_PO=$(usex nls)
		-DEXIV2_ENABLE_NLS=$(usex nls)
		-DEXIV2_ENABLE_PNG=$(usex png)
		-DEXIV2_ENABLE_CURL=$(usex webready)
		-DEXIV2_ENABLE_SSH=$(usex webready)
		-DEXIV2_ENABLE_WEBREADY=$(usex webready)
		-DEXIV2_ENABLE_XMP=$(usex xmp)
		-DEXIV2_ENABLE_LIBXMP=NO
		$(multilib_is_native_abi || echo -DEXIV2_ENABLE_TOOLS=NO)
	)

	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile

	if multilib_is_native_abi; then
		use doc && emake -j1 doc
	fi
}
