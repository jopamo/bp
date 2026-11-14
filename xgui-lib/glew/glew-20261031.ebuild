# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="The OpenGL Extension Wrangler Library"
HOMEPAGE="http://glew.sourceforge.net/"
SNAPSHOT=f1dbf34dec2f728844dc7a79779a29d090ba5afb
OPENGL_REGISTRY_SNAPSHOT=6af574a14089ccfee87efe230ebcdd8742859813
EGL_REGISTRY_SNAPSHOT=8e56e86e65687697ef54114cdb1afabdfac756bf
GLFIXES_SNAPSHOT=b63c8d3e676097d610efda64870cbe6f10543bd3
# lockstep-branch: GLFIXES_SNAPSHOT glew
SRC_URI="
	https://github.com/nigels-com/glew/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/KhronosGroup/OpenGL-Registry/archive/${OPENGL_REGISTRY_SNAPSHOT}.tar.gz -> OpenGL-Registry-${OPENGL_REGISTRY_SNAPSHOT}.tar.gz
	https://github.com/KhronosGroup/EGL-Registry/archive/${EGL_REGISTRY_SNAPSHOT}.tar.gz -> EGL-Registry-${EGL_REGISTRY_SNAPSHOT}.tar.gz
	https://github.com/nigels-com/glfixes/archive/${GLFIXES_SNAPSHOT}.tar.gz -> glfixes-${GLFIXES_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xmedia-lib/glu
	>=xgui-tools/mesa-7.0-r1
	>=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	>=xgui-lib/libXi-1.7.2
	>=xgui-lib/libXmu-1.1.1-r1
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-lang/perl
	app-lang/python
"

src_prepare() {
	mv "${WORKDIR}/OpenGL-Registry-${OPENGL_REGISTRY_SNAPSHOT}" auto/OpenGL-Registry || die
	mv "${WORKDIR}/EGL-Registry-${EGL_REGISTRY_SNAPSHOT}" auto/EGL-Registry || die
	mv "${WORKDIR}/glfixes-${GLFIXES_SNAPSHOT}" auto/glfixes || die
	# The registries are fetched through SRC_URI, not the generator's git rules.
	touch auto/OpenGL-Registry/.dummy auto/EGL-Registry/.dummy || die

	sed -i \
		-e '/INSTALL/s:-s::' \
		-e '/$(CC) $(CFLAGS) -o/s:$(CFLAGS):$(CFLAGS) $(LDFLAGS):' \
		-e '/^.PHONY: .*\.pc$/d' \
		Makefile || die

	if ! use static-libs ; then
		sed -i \
			-e 's/^glew.lib: .*/glew.lib: glew.lib.shared/' \
			-e '/INSTALL.*LIB.STATIC/d' \
			Makefile || die
	fi

	# don't do stupid Solaris specific stuff that won't work in Prefix
	cp config/Makefile.linux config/Makefile.solaris || die
	# and let freebsd be built as on linux too
	cp config/Makefile.linux config/Makefile.freebsd || die

	default
}

glew_system() {
	# Set the SYSTEM variable instead of probing. #523444 #595280
	case ${CHOST} in
	*linux*)          echo "linux" ;;
	*-freebsd*)       echo "freebsd" ;;
	*-darwin*)        echo "darwin" ;;
	*-solaris*)       echo "solaris" ;;
	mingw*|*-mingw*)  echo "mingw" ;;
	*) die "Unknown system ${CHOST}" ;;
	esac
}

set_opts() {
	myglewopts=(
		AR="$(tc-getAR)"
		STRIP=true
		CC="$(tc-getCC)"
		LD="$(tc-getCC) ${LDFLAGS}"
		SYSTEM="$(glew_system)"
		M_ARCH=""
		LDFLAGS.EXTRA=""
		POPT="${CFLAGS}"
	)
}

src_compile() {
	qa-policy-configure
	set_opts
	# Other header rules can run before glew.h creates this directory.
	mkdir -p include/GL || die
	emake -C auto PYTHON=python3
	emake \
		GLEW_PREFIX="${EPREFIX}/usr" \
		GLEW_DEST="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}/usr/lib" \
		"${myglewopts[@]}"
}

src_install() {
	set_opts
	emake \
		GLEW_DEST="${ED}/usr" \
		LIBDIR="${ED}/usr/lib" \
		PKGDIR="${ED}/usr/lib/pkgconfig" \
		"${myglewopts[@]}" \
		install.all
	qa-policy-install
}
