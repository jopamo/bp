# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="EXIF, IPTC and XMP metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"
EGIT_REPO_URI="https://github.com/Exiv2/exiv2.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)-maintenance"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls png static-libs webready xmp"

RDEPEND="
	nls? ( >=sys-devel/gettext-0-r1 )
	png? ( >=lib-core/zlib-1.2.8-r1 )
	webready? (
		lib-net/libssh
		app-net/curl
	)
	xmp? ( >=lib-core/expat-2.1.0-r3 )
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
"

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

	cmake_src_prepare
}

src_configure() {
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
	)

	cmake_src_configure
}
