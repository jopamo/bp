# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"
SNAPSHOT=b2eb30be4340cbcb9c534c4bc347a387048ccfe3
SDB_SNAPSHOT=b2c50e519f0b1dc7edf2417281e46bc793cd40a6
V35ARMV7_SNAPSHOT=7d7a78f52196f6333bd5746dc526684edbfd9af0
V35ARM64_SNAPSHOT=adfc7238a27ef279cc83f3076c6b107573f75444
QJS_SNAPSHOT=66adc822eb0f0ac65e6b73d9a5c3fac50e43224e
CAPSTONE_SNAPSHOT=d0354906833de7eaebf7786af5624c0a8307ce14

inherit flag-o-matic toolchain-funcs

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="https://www.radare.org"
SRC_URI="
	https://github.com/radareorg/radare2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/radareorg/sdb/archive/${SDB_SNAPSHOT}.tar.gz -> sdb-${SDB_SNAPSHOT}.tar.gz
	https://github.com/radareorg/vector35-arch-armv7/archive/${V35ARMV7_SNAPSHOT}.tar.gz -> vector35-arch-armv7-${V35ARMV7_SNAPSHOT}.tar.gz
	https://github.com/radareorg/vector35-arch-arm64/archive/${V35ARM64_SNAPSHOT}.tar.gz -> vector35-arch-arm64-${V35ARM64_SNAPSHOT}.tar.gz
	https://github.com/quickjs-ng/quickjs/archive/${QJS_SNAPSHOT}.tar.gz -> quickjs-${QJS_SNAPSHOT}.tar.gz
	https://github.com/capstone-engine/capstone/archive/${CAPSTONE_SNAPSHOT}.tar.gz -> capstone-${CAPSTONE_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/radare2-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

DEPEND="
	app-compression/libzip
	lib-misc/xxhash
"

src_prepare() {
	default

	rm -rf subprojects/{sdb,v35armv7,v35arm64,qjs,capstone-v5} || die

	mv "${WORKDIR}/sdb-${SDB_SNAPSHOT}" subprojects/sdb || die
	mv "${WORKDIR}/vector35-arch-armv7-${V35ARMV7_SNAPSHOT}" subprojects/v35armv7 || die
	mv "${WORKDIR}/vector35-arch-arm64-${V35ARM64_SNAPSHOT}" subprojects/v35arm64 || die
	mv "${WORKDIR}/quickjs-${QJS_SNAPSHOT}" subprojects/qjs || die
	mv "${WORKDIR}/capstone-${CAPSTONE_SNAPSHOT}" subprojects/capstone-v5 || die

	cp -a subprojects/packagefiles/qjs/. subprojects/qjs/ || die
	cp -a subprojects/packagefiles/capstone-v5/. subprojects/capstone-v5/ || die
}

src_configure() {
	filter-flags -Wl,-z,defs -flto*
	tc-is-clang || append-flags -fno-ipa-sra
	filter-flags -fipa-pta

	econf \
	--with-syslz4 \
	--with-sysmagic \
	--with-libatomic \
	--with-syszip \
	--with-sysxxhash \
	--with-ssl \
	--with-ssl-crypto
}

src_compile() {
	emake OSTYPE=gnulinux
}
