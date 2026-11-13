# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"
SNAPSHOT=fb625fccf20eb8329c4c0698f9e0351b5647b8cd
SDB_SNAPSHOT=8edd753d2e2be2f4f90f587f96f80ca90c8433ae
V35ARMV7_SNAPSHOT=7d7a78f52196f6333bd5746dc526684edbfd9af0
V35ARM64_SNAPSHOT=adfc7238a27ef279cc83f3076c6b107573f75444
QJS_SNAPSHOT=71e6367f050b42f25d8e5849425070c322705d63
CAPSTONE_SNAPSHOT=823242a51299ce5a8bac79c0914278419fe4f7a6

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
BDEPEND="app-dev/gperf"

PATCHES=(
	"${FILESDIR}"/radare2-20261016-qjs-interrupt-handler-context.patch
)

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
