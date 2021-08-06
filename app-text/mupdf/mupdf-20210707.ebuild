# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs git-r3

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
EGIT_REPO_URI="https://github.com/ArtifexSoftware/mupdf.git"
EGIT_COMMIT=d00de0e96a4a5ec90ffc30837d40cd624a6a89e0
EGIT_SUBMODULES=( thirdparty/lcms2 thirdparty/mujs )

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X opengl static static-libs"

LIB_DEPEND="
	xmedia-live-lib/freetype:2[static-libs?]
	xmedia-live-lib/harfbuzz[static-libs?]
	xmedia-live-lib/jbig2dec[static-libs?]
	xmedia-live-lib/libpng:0[static-libs?]
	>=xmedia-live-lib/openjpeg-2.1:2[static-libs?]
	xmedia-live-lib/libjpeg-turbo[static-libs?]
	lib-dev/gumbo-parser[static-libs?]
	X? ( x11-live-lib/libX11[static-libs?]
		x11-live-lib/libXext[static-libs?] )
"
RDEPEND="${LIB_DEPEND}"
DEPEND="${RDEPEND}
	xmedia-live-lib/freeglut
	dev-util/pkgconf
	static-libs? ( ${LIB_DEPEND} )
	static? ( ${LIB_DEPEND//?}
		app-compression/lbzip2[static-libs]
		x11-live-lib/libXau[static-libs]
		x11-live-lib/libXdmcp[static-libs]
		xgui-live-lib/libxcb[static-libs] )"

REQUIRED_USE="opengl? ( !static !static-libs )"

PATCHES=( "${FILESDIR}"/mupdf_build.patch )

src_prepare() {
	default

	sed -e '/* #define FZ_ENABLE_JS/ a\#define FZ_ENABLE_JS 0' \
		-i include/mupdf/fitz/config.h

	sed -e "1iOS = Linux" \
		-e "1iCC = $(tc-getCC)" \
		-e "1iLD = $(tc-getLD)" \
		-e "1iAR = $(tc-getAR)" \
		-e "1iverbose = yes" \
		-e "1ibuild = debug" \
		-e "1iprefix = ${ED}/usr" \
		-e "1ilibdir = ${ED}/usr/lib" \
		-e "1idocdir = ${ED}/usr/share/doc/${PF}" \
		-i Makerules || die

	rm -rf thirdparty/{freeglut,freetype,harfbuzz,jbig2dec,libjpeg,openjpeg,zlib}
}

_emake() {
	emake \
		HAVE_GLUT=$(usex opengl) \
		HAVE_CURL=no \
		HAVE_LIBCRYPTO=no \
		HAVE_X11=$(usex X) \
		USE_SYSTEM_LIBS=yes \
		USE_SYSTEM_MUJS=no \
		HAVE_OBJCOPY=no \
		"$@"
}

src_compile() {
	_emake XCFLAGS="-fpic"

	use static-libs && \
		_emake build/debug/lib${PN}.a
}

src_install() {
	rm docs/man/${PN}.1

	_emake install

	for x in libmupdf.so.1 libmupdf.so.1.0 libmupdf.so ; do
		dosym libmupdf.so.${PV} usr/lib/${x}
	done

	use static-libs && \
		dolib.a build/debug/lib${PN}.a
	if use opengl ; then
		dosym ${PN}-gl /usr/bin/${PN}
	elif use X ; then
		dosym ${PN}-x11 /usr/bin/${PN}
	fi

	cleanup_install
}
