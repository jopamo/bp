# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI="https://mupdf.com/downloads/archive/${P}-source.tar.xz"

LICENSE="AGPL-3"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

IUSE="X opengl static static-libs"

LIB_DEPEND="
	lib-media/freetype:2[static-libs?]
	lib-media/harfbuzz[static-libs?]
	lib-media/jbig2dec[static-libs?]
	lib-media/libpng:0[static-libs?]
	>=lib-media/openjpeg-2.1:2[static-libs?]
	lib-media/libjpeg-turbo[static-libs?]
	X? ( x11-libs/libX11[static-libs?]
		x11-libs/libXext[static-libs?] )
	opengl? ( >=lib-media/glfw-3.2 )"
RDEPEND="${LIB_DEPEND}"
DEPEND="${RDEPEND}
	lib-media/freeglut
	dev-util/pkgconf
	static-libs? ( ${LIB_DEPEND} )
	static? ( ${LIB_DEPEND//?}
		app-compression/lbzip2[static-libs]
		x11-libs/libXau[static-libs]
		x11-libs/libXdmcp[static-libs]
		x11-libs/libxcb[static-libs] )"

REQUIRED_USE="opengl? ( !static !static-libs )"

S=${WORKDIR}/${P}-source

PATCHES=(
	"${FILESDIR}"/${PN}-1.14-CFLAGS.patch
	"${FILESDIR}"/${PN}-1.14-Makefile.patch
	"${FILESDIR}"/${PN}-1.14-fix-big-endian.patch
)

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
		-e "1iprefix = ${ED}usr" \
		-e "1ilibdir = ${ED}usr/lib" \
		-e "1idocdir = ${ED}usr/share/doc/${PF}" \
		-i Makerules || die
}

_emake() {
	emake \
		GENTOO_PV=${PV} \
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

	dosym libmupdf.so.${PV} /usr/lib/lib${PN}.so

	use static-libs && \
		dolib.a build/debug/lib${PN}.a
	if use opengl ; then
		einfo "mupdf symlink points to mupdf-gl (bug 616654)"
		dosym ${PN}-gl /usr/bin/${PN}
	elif use X ; then
		einfo "mupdf symlink points to mupdf-x11 (bug 616654)"
		dosym ${PN}-x11 /usr/bin/${PN}
	fi
}
