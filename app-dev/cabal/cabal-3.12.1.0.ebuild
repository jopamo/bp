# Distributed under the terms of the GNU General Public License v2

inherit hackage

DESCRIPTION="Command-line interface for Cabal and Hackage"
HOMEPAGE="https://www.haskell.org/cabal/"
SRC_URI="
	https://downloads.haskell.org/~cabal/cabal-install-${PV}/cabal-install-${PV}.tar.gz
	amd64? (
		elibc_musl? (
			https://downloads.haskell.org/~cabal/cabal-install-${PV}/cabal-install-${PV}-x86_64-linux-alpine3_18.tar.xz
				-> ${P}-bootstrap-amd64-musl.tar.xz
		)
		!elibc_musl? (
			https://downloads.haskell.org/~cabal/cabal-install-${PV}/cabal-install-${PV}-x86_64-linux-deb12.tar.xz
				-> ${P}-bootstrap-amd64-glibc.tar.xz
		)
	)
	arm64? (
		elibc_musl? (
			https://downloads.haskell.org/~cabal/cabal-install-${PV}/cabal-install-${PV}-aarch64-linux-alpine3_18.tar.xz
				-> ${P}-bootstrap-arm64-musl.tar.xz
		)
		!elibc_musl? (
			https://downloads.haskell.org/~cabal/cabal-install-${PV}/cabal-install-${PV}-aarch64-linux-deb12.tar.xz
				-> ${P}-bootstrap-arm64-glibc.tar.xz
		)
	)
"
S="${WORKDIR}/cabal-install-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-util/numactl
	lib-core/gmp
	lib-core/libffi
	lib-core/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="app-lang/ghc"

RESTRICT="strip test"

HACKAGE_ROOTS=(
	"async"
	"base16-bytestring"
	"cabal-install"
	"cabal-install-solver"
	"cryptohash-sha256"
	"directory-ospath-streaming"
	"echo"
	"edit-distance"
	"file-io"
	"hackage-security"
	"hashable"
	"HTTP"
	"hsc2hs"
	"network-uri"
	"open-browser"
	"random"
	"regex-base"
	"regex-posix"
	"safe-exceptions"
	"semaphore-compat"
	"tar"
	"zlib"
)
HACKAGE_PRIMARY_PACKAGE="cabal-install"
HACKAGE_VERSION_SOURCE="cabal-install-solver"

# lockstep-hackage-managed: true
# lockstep-hackage-deps: begin
HACKAGE_SNAPSHOT="lts-24.56"
HACKAGE_DEPS=(
	"async 2.2.6 0 45d5587d8a348a7e2b3f04de963fe633db49b49cde10ca1e6f834bef3baecee9"
	"atomic-counter 0.1.2.4 0 51c0178c727ef4ccd694514c0a44369eb8593ae83dde42bc5fb5c89d5b4c60b5"
	"base16-bytestring 1.0.2.0 1 a694e88f9ec9fc79f0b03f233d3fea592b68f70a34aac2ddb5bcaecb6562e2fd"
	"base64-bytestring 1.2.1.0 1 45305ccf8914c66d385b518721472c7b8c858f1986945377f74f85c1e0d49803"
	"cabal-install 3.12.1.0 4 6e1e6ec2ed1bf8ee143a02df63554278e8c12c564e0795f0ed24d13918c7fa9c"
	"cabal-install-solver 3.12.1.0 1 4f650233af2a31864246f487385cfb163ff8e9537cefb5be7a604b57c748512d"
	"cryptohash-sha256 0.11.102.1 6 0e9de2ccce261e7a5b027e842f6f47f50eb0e6059a0de98a5479f75aa8164107"
	"directory-ospath-streaming 0.2.2 1 b24ec42ce02c42a76732323c4e59414d9b5439ac5fa99304412719ba7f4c6a3f"
	"echo 0.1.4 0 ccce771562c49a2b29a52046ca68c62179e97e8fbeacdae32ca84a85445e8f42"
	"ed25519 0.0.5.0 9 f1550ddbe3b53f1087a035667364011460896cc2b1ff328b521c05ed5973bb78"
	"edit-distance 0.2.2.1 1 4d33a49cd383d50af090f1b888642d10116e43809f9da6023d9fc6f67d2656ee"
	"file-io 0.1.6 0 5e3466f15993e499db47d79d09c519d6d37c143cfe94fb46dd218bf2f6f3fd39"
	"hackage-security 0.6.4.0 0 3e65c97a175b8bf004213d9c098039752c46cc616ed7ee49c987ad011ab01042"
	"hashable 1.5.1.0 0 140fc5adad166f7b527567cbd26ff481e8da4a66bdfc84be3ddf28dbeb66f275"
	"hsc2hs 0.68.10 5 39b25fd929b02b01a3fe59fec7ca8b2da6f0f9e282276b7a84e63a4702c4d725"
	"HTTP 4000.4.1 6 ad36c6a1b3bc203b02751c8bffae8a684cc755661a2a567362cd4a0da1193c5e"
	"lukko 0.1.2 2 eca91c02ccdc050cd335224af22a31a7d03f9f799a95227f0b8117be43311e1d"
	"network 3.2.9.0 0 48a0c4f91e460f892c629b76c9410336a978e9b58aa87c678aee587b4ca37698"
	"network-uri 2.6.4.2 1 6fffb57373962b5651a2db8b0af732098b3bf029a7ced76a9855615de2026588"
	"open-browser 0.4.0.0 0 a5effff3d14a0bbfde51dd62e72cff069b56be4298f16a78db7d3cc0c678c859"
	"random 1.2.1.3 0 117541ba0a177397a3333f94870f789ef050dca31b0688a19824b2bc401b8823"
	"regex-base 0.94.0.3 0 d6c0c6d1136f5046207a331114ff4130e70640452096de7719bf03e3fceb7c7b"
	"regex-posix 0.96.0.2 0 faf170ca5073e8d538a7a18f727a02a96f2a36c5fd53a1696263a70ab81bc6fe"
	"safe-exceptions 0.1.7.4 1 8bb7261bd54bd58acfcb154be6a161fb6d0d31a1852aadc8e927d2ad2d7651d1"
	"semaphore-compat 1.0.0 4 2dff81c2c0ec9bac9f8bae364db497188654d2e1e4330f4a0e2f12310149f3e9"
	"splitmix 0.1.3.2 0 a557cff65eed1f70f3a3b468423cd58e7a9a9564c5cc00c76a13de64dec9bcbd"
	"tar 0.6.4.0 4 1a5ff2b64cd1bac53ea68d057631818cab6edf7108dc86e7be8ad020b2bf2580"
	"th-compat 0.1.7 0 449be09a4e3f46ea4645700c026624c4b6f066f508187326c284dbdea8884bc9"
	"unordered-containers 0.2.20.1 0 e2ee0d7d8f19747d8c4a0f0a3aa617b1ce1317abd2904c743c04fda25feec685"
	"zlib 0.7.1.1 0 cf2f8f91b10b635bdaa2c3010f40a5562a06ede24b92d819758e7f1b7d04f9f2"
)

hackage_set_globals
# lockstep-hackage-deps: end

src_compile() {
	HACKAGE_CABAL="${WORKDIR}/cabal" \
		hackage_cabal_build exe:cabal \
		--flags="-native-dns -lukko"

	HACKAGE_CABAL="${WORKDIR}/cabal" \
		hackage_cabal_list_bin exe:cabal \
		--flags="-native-dns -lukko" > "${T}/cabal-bin" || die
}

src_install() {
	dobin "$(cat "${T}/cabal-bin")"
}
