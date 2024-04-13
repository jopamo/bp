# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A decoder implementation of the JBIG2 image compression format"
HOMEPAGE="http://ghostscript.com/jbig2dec.html"

SNAPSHOT=ee53a7e4bc7819d32e8c0b2057885bcc97586bf3
SRC_URI="https://github.com/ArtifexSoftware/jbig2dec/archive/${SNAPSHOT}.tar.gz -> jbig2dec-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jbig2dec-${SNAPSHOT}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="png static-libs test"

DEPEND="png? ( xmedia-lib/libpng:0= )"

src_prepare() {
	VERSIONGREP="sed -e s/.*[^0-9\.]\([0-9][0-9]*\.[0-9][0-9]*\).*/\1/"
	VERSIONMKMAJ="sed -e s/\([0-9][0-9]*\)[^0-9].*/\\1/"
	VERSIONMKMIN="sed -e s/.*[0-9][0-9]*\.//"

	JBIG2VERSIONGREP="sed -e s/^.*(\([0-9][0-9]*\)).*/\\1/"
	JBIG2MAJOR=$(grep 'define JBIG2_VERSION_MAJOR' jbig2.h | $JBIG2VERSIONGREP)
	JBIG2MINOR=$(grep 'define JBIG2_VERSION_MINOR' jbig2.h | $JBIG2VERSIONGREP)
	sed -e "s/^\(AC_INIT[^,]*,\)[^,]*\(,.*\)$/\1 [$JBIG2MAJOR.$JBIG2MINOR]\2/" configure.ac.in > configure.ac

	echo "  creating config_types.h.in"

cat >config_types.h.in <<EOF
/*
   generated header with missing types for the
   jbig2dec program and library. include this
   after config.h, within the HAVE_CONFIG_H
   ifdef
*/

#ifdef HAVE_STDINT_H
#  include <stdint.h>
#else
#  ifdef JBIG2_REPLACE_STDINT_H
#   include <@JBIG2_STDINT_H@>
#  else
    typedef unsigned @JBIG2_INT32_T@ uint32_t;
    typedef unsigned @JBIG2_INT16_T@ uint16_t;
    typedef unsigned @JBIG2_INT8_T@ uint8_t;
    typedef signed @JBIG2_INT32_T@ int32_t;
    typedef signed @JBIG2_INT16_T@ int16_t;
    typedef signed @JBIG2_INT8_T@ int8_t;
#  endif /* JBIG2_REPLACE_STDINT */
#endif /* HAVE_STDINT_H */
EOF

	eautoreconf
	default
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_with png libpng)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
