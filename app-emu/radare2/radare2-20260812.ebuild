# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"
SNAPSHOT=9a02d71ad3f0a03cdcf3e13b30f89f71e1c4e697
SDB_SNAPSHOT=72ff1b2d4993c71d2321af8577d9795b5f97d334
V35ARMV7_SNAPSHOT=7d7a78f52196f6333bd5746dc526684edbfd9af0
V35ARM64_SNAPSHOT=adfc7238a27ef279cc83f3076c6b107573f75444
QJS_SNAPSHOT=82626eacc81825340736af5a6f363f5ebdf8aede
CAPSTONE_SNAPSHOT=768166e427b15ada8bc92f86add6b45ce15c64bc

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
