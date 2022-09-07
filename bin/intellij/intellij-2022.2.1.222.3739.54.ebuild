# Distributed under the terms of the GNU General Public License v2

EAPI=8

IDEA_VER="2.49836838.1031729952.1658961170-1305167137.1658527855"
MY_PV="$(ver_cut 1-2)"

inherit xdg wrapper

DESCRIPTION="A complete toolset for web, mobile and enterprise development"
HOMEPAGE="https://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/idea/ideaIC-${MY_PV}.tar.gz?_ga=${IDEA_VER} -> ${P}.tar.gz"
S="${WORKDIR}/idea-IC-$(ver_cut 3-6)"

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

	rm -r lib/pty4j-native/linux/aarch64 || die
	rm -r lib/pty4j-native/linux/arm || die
	rm -r lib/pty4j-native/linux/mips64el || die
	rm -r lib/pty4j-native/linux/ppc64le || die
	rm -r plugins/cwm-plugin/quiche-native/linux-aarch64 || die
	rm -r plugins/maven/lib/maven3/lib/jansi-native/freebsd32 || die
	rm -r plugins/maven/lib/maven3/lib/jansi-native/freebsd64 || die
	rm -r plugins/maven/lib/maven3/lib/jansi-native/linux32 || die
	rm lib/pty4j-native/linux/x86/libpty.so || die
	rm plugins/Kotlin/bin/linux/LLDBFrontend || die
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
