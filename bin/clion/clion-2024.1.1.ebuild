# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg wrapper

DESCRIPTION="JetBrains CLion: cross-platform C and C++ IDE"
HOMEPAGE="https://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/cpp/CLion-${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/idea-IC-${PV}"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 CC-BY-2.5 CDDL-1.1
	codehaus-classworlds CPL-1.0 EPL-1.0 EPL-2.0
	GPL-2 GPL-2-with-classpath-exception ISC
	JDOM LGPL-2.1 LGPL-2.1+ LGPL-3-with-linking-exception MIT
	MPL-1.0 MPL-1.1 OFL ZLIB"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip"

QA_PREBUILT="opt/${PN}/*"

src_unpack() {

	default_src_unpack
	if [ ! -d "$S" ]; then
		einfo "Renaming source directory to predictable name..."
		mv $(ls "${WORKDIR}") "idea-IC-${PV}" || die
	fi
}

src_install() {
	local HERE="${ED}/opt/${PN}"

	mkdir -p "${HERE}" || die
	cp -rp "${S}"/* "${HERE}/" || die

	make_wrapper idea "/opt/${PN}/bin/idea.sh"
}
