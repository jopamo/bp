# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs xdg

DESCRIPTION="A lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="https://mupdf.com/ https://git.ghostscript.com/?p=mupdf.git"
SRC_URI="https://mupdf.com/downloads/archive/${P}-source.tar.gz"

S="${WORKDIR}"/${P}-source

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="javascript opengl ssl X"

REQUIRED_USE="opengl? ( javascript )"

LIB_DEPEND="
	xgui-lib/freetype
	xgui-lib/harfbuzz
	xmedia-lib/jbig2dec
	xmedia-lib/libpng
	xmedia-lib/openjpeg
	xmedia-lib/libjpeg-turbo
	lib-misc/gumbo-parser
	X? ( xgui-lib/libX11
		xgui-lib/libXext )
"
RDEPEND="${LIB_DEPEND}"
DEPEND="${RDEPEND}
	xgui-lib/freeglut
	app-dev/pkgconf
	app-compression/bzip2
	xgui-lib/libXau
	xgui-lib/libXdmcp
	xgui-lib/libxcb
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.15-CFLAGS.patch
	"${FILESDIR}"/${PN}-1.19.0-Makefile.patch
	"${FILESDIR}"/${PN}-1.21.0-add-desktop-pc-files.patch
	# See bugs #662352
	"${FILESDIR}"/${P}-openssl-x11.patch
	# General cross fixes from Debian (refreshed)
	"${FILESDIR}"/${P}-cross-fixes.patch
	"${FILESDIR}"/${PN}-1.21.1-fix-aliasing-violation.patch
)

src_prepare() {
	default

	append-cflags "-DFZ_ENABLE_JS=$(usex javascript 1 0)"

	sed -e "1iOS = Linux" \
		-e "1iCC = $(tc-getCC)" \
		-e "1iCXX = $(tc-getCXX)" \
		-e "1iLD = $(tc-getLD)" \
		-e "1iAR = $(tc-getAR)" \
		-e "1iverbose = yes" \
		-e "1ibuild = debug" \
		-i Makerules || die "Failed adding build variables to Makerules in src_prepare()"

	# Adjust MuPDF version in .pc file created by the
	# mupdf-1.10a-add-desktop-pc-xpm-files.patch file
	sed -e "s/Version: \(.*\)/Version: ${PV}/" \
		-i platform/debian/${PN}.pc || die "Failed substituting version in ${PN}.pc"
}

_emake() {
	# When HAVE_OBJCOPY is yes, we end up with a lot of QA warnings.
	#
	# Bundled libs
	# * General
	# Note that USE_SYSTEM_LIBS=yes is a metaoption which will set to upstream's
	# recommendations. It does not mean "always use system libs".
	# See [0] below for what it means in a specific version.
	#
	# * freeglut
	# We don't use system's freeglut because upstream has a special modified
	# version of it that gives mupdf clipboard support. See bug #653298
	#
	# * mujs
	# As of v1.15.0, mupdf started using symbols in mujs that were not part
	# of any release. We then went back to using the bundled version of it.
	# But v1.17.0 looks ok, so we'll go unbundled again. Be aware of this risk
	# when bumping and check!
	# See bug #685244
	#
	# * lmms2
	# mupdf uses a bundled version of lcms2 [0] because Artifex have forked it [1].
	# It is therefore not appropriate for us to unbundle it at this time.
	#
	# [0] https://git.ghostscript.com/?p=mupdf.git;a=blob;f=Makethird;h=c4c540fa4a075df0db85e6fdaab809099881f35a;hb=HEAD#l9
	# [1] https://www.ghostscript.com/doc/lcms2mt/doc/WhyThisFork.txt
	local myemakeargs=(
		GENTOO_PV=${PV}
		HAVE_GLUT=$(usex opengl)
		HAVE_LIBCRYPTO=$(usex ssl)
		HAVE_X11=$(usex X)
		USE_SYSTEM_LIBS=yes
		USE_SYSTEM_MUJS=no
		USE_SYSTEM_GLUT=no
		HAVE_OBJCOPY=no
		"$@"
	)

	emake "${myemakeargs[@]}"
}

src_compile() {
	tc-export PKG_CONFIG

	_emake XCFLAGS="-fPIC"
}

src_install() {
	if use opengl || use X ; then
		insinto /usr/share/applications/
		doins platform/debian/${PN}.desktop

		insinto /usr/share/icons/
		doins docs/logo/new-${PN}-icon.svg
	else
		rm docs/man/${PN}.1 || die "Failed to remove man page in src_install()"
	fi

	sed -i \
		-e "1iprefix = ${ED}/usr" \
		-e "1ilibdir = ${ED}/usr/lib" \
		-e "1idocdir = ${ED}/usr/share/doc/${PF}" \
		-i Makerules || die "Failed adding liprefix, lilibdir and lidocdir to Makerules in src_install()"

	_emake install

	dosym libmupdf.so.${PV} /usr/lib/lib${PN}.so

	if use opengl ; then
		einfo "mupdf symlink points to mupdf-gl (bug 616654)"
		dosym ${PN}-gl /usr/bin/${PN}
	elif use X ; then
		einfo "mupdf symlink points to mupdf-x11 (bug 616654)"
		dosym ${PN}-x11 /usr/bin/${PN}
	fi

	# Respect libdir (bug #734898)
	sed -i -e "s:/lib:/lib:" platform/debian/${PN}.pc \
		|| die "Failed to sed pkgconfig file to respect libdir in src_install()"

	insinto /usr/lib/pkgconfig
	doins platform/debian/${PN}.pc
}
