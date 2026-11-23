# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="master"
SNAPSHOT=4b2b722e23278a5cadb79d914f4274ee73779518
# Match subprojects/*.wrap: these sources are patched during src_prepare.
SDB_SNAPSHOT=493d5ced7e81409c908a61a27dd58410b3c68d67
V35ARMV7_SNAPSHOT=7d7a78f52196f6333bd5746dc526684edbfd9af0
V35ARM64_SNAPSHOT=adfc7238a27ef279cc83f3076c6b107573f75444
QJS_SNAPSHOT=b51e5278439b2fa0510fbb1f3b3dff9f0064d5d7
CAPSTONE_SNAPSHOT=2461ca7372067eeb6197f0df048f767a8db3bca3

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
	"${FILESDIR}"/radare2-20261123-use-staged-dependencies.patch
)

src_prepare() {
	default

	rm -rf subprojects/{sdb,v35armv7,v35arm64,qjs,capstone-v5} || die

	mv "${WORKDIR}/sdb-${SDB_SNAPSHOT}" subprojects/sdb || die
	mv "${WORKDIR}/vector35-arch-armv7-${V35ARMV7_SNAPSHOT}" subprojects/v35armv7 || die
	mv "${WORKDIR}/vector35-arch-arm64-${V35ARM64_SNAPSHOT}" subprojects/v35arm64 || die
	mv "${WORKDIR}/quickjs-${QJS_SNAPSHOT}" subprojects/qjs || die
	mv "${WORKDIR}/capstone-${CAPSTONE_SNAPSHOT}" subprojects/capstone-v5 || die

	local project patch_list patch_file
	local -a patches
	for project in sdb qjs capstone-v5; do
		cp -a "subprojects/packagefiles/${project}/." "subprojects/${project}/" || die
		patch_list=$(sed -n 's/^diff_files = //p' "subprojects/${project}.wrap") || die
		IFS=, read -r -a patches <<< "${patch_list}"
		for patch_file in "${patches[@]}"; do
			patch_file=${patch_file# }
			(
				cd "subprojects/${project}" || die
				eapply "${S}/subprojects/${patch_file}"
			) || die "failed applying ${patch_file}"
		done
	done
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
