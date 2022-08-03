# Distributed under the terms of the GNU General Public License v2

EAPI=8

IDEA_VER="2.49836838.1031729952.1658961170-1305167137.1658527855"
MY_PV="$(ver_cut 1-2)"

inherit xdg

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

src_prepare() {
	default

	rm -r lib/pty4j-native/linux/aarch64
	rm -r lib/pty4j-native/linux/arm
	rm -r lib/pty4j-native/linux/mips64el
	rm -r lib/pty4j-native/linux/ppc64le
	rm lib/pty4j-native/linux/x86/libpty.so
	rm plugins/Kotlin/bin/linux/LLDBFrontend
	rm -r plugins/maven/lib/maven3/lib/jansi-native/freebsd32
	rm -r plugins/maven/lib/maven3/lib/jansi-native/freebsd64
	rm -r plugins/maven/lib/maven3/lib/jansi-native/linux32
	rm plugins/webp/lib/libwebp/linux/libwebp_jni.so
}

src_install() {
	mkdir -p "${ED}"/opt/${PN}/
	cp -rp "${S}"/* "${ED}"/opt/${PN}/
}
