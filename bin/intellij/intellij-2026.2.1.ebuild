# Distributed under the terms of the GNU General Public License v2

inherit xdg doins

DESCRIPTION="IntelliJ IDEA: a complete toolset for software development"
HOMEPAGE="https://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/idea/idea-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/idea-IU-262.9437.185"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 CC-BY-2.5 CDDL-1.1
	codehaus-classworlds CPL-1.0 EPL-1.0 EPL-2.0
	GPL-2 GPL-2-with-classpath-exception ISC
	JDOM LGPL-2.1 LGPL-2.1+ LGPL-3-with-linking-exception MIT
	MPL-1.0 MPL-1.1 OFL ZLIB"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip"

QA_PREBUILT="opt/${PN}/*"

RDEPEND="app-fs/e2fsprogs"

src_prepare() {
	default

	rm plugins/webp/lib/libwebp/linux/libwebp_jni.so || die
}

src_install() {
	local HERE="${ED}/opt/${PN}"

	mkdir -p "${HERE}" || die
	cp -rp "${S}"/* "${HERE}/" || die

	make_wrapper idea "/opt/${PN}/bin/idea.sh"

	insinto /usr/share/icons/hicolor/scalable/apps/
	doins "${S}"/bin/idea.svg

	insinto /usr/share/applications/
	doins "${FILESDIR}"/idea.desktop
}
