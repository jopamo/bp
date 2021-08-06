# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a free and open-source implementation of the Java Platform"
HOMEPAGE="https://openjdk.java.net/"
SRC_URI="amd64? ( https://github.com/AdoptOpenJDK/openjdk$(ver_cut 1)-binaries/releases/download/jdk$(ver_cut 1)u$(ver_cut 2)-b10/OpenJDK$(ver_cut 1)U-jre_x64_linux_hotspot_$(ver_cut 1)u$(ver_cut 2)b10.tar.gz )
		arm64? ( https://github.com/AdoptOpenJDK/openjdk$(ver_cut 1)-binaries/releases/download/jdk$(ver_cut 1)u$(ver_cut 2)-b10/OpenJDK$(ver_cut 1)U-jre_aarch64_linux_hotspot_$(ver_cut 1)u$(ver_cut 2)b10.tar.gz )"

S=${WORKDIR}/jdk$(ver_cut 1)u$(ver_cut 2)-b10-jre

LICENSE="https://openjdk.java.net/legal/"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="!dev-lang/oracle-jre"

RESTRICT="preserve-libs strip"

QA_PREBUILT="*"

src_compile() { :;}

src_install() {
	mkdir -p "${ED}"/opt/ || die
	cp -pPR	bin lib "${ED}"/opt/ || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die
	rm "${ED}"/opt/lib/amd64/server/libjsig.debuginfo
}
