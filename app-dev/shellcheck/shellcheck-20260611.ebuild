# Distributed under the terms of the GNU General Public License v2

inherit hackage

DESCRIPTION="Shell script analysis tool"
HOMEPAGE="https://www.shellcheck.net https://github.com/koalaman/shellcheck"
SNAPSHOT=9af7ee28ce587baadd950b85dd6826a16b9c068d
SRC_URI="https://github.com/koalaman/shellcheck/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-util/numactl
	lib-core/gmp
	lib-core/libffi
"
DEPEND="${RDEPEND}"
BDEPEND="app-dev/cabal"

RESTRICT="test"

DOCS=( CHANGELOG.md README.md shellcheck.1.md )

HACKAGE_ROOTS=(
	"aeson"
	"doctest"
	"Diff"
	"fgl"
	"QuickCheck"
	"regex-tdfa"
	"tasty"
	"tasty-bench"
	"tasty-hunit"
	"tasty-inspection-testing"
	"tasty-quickcheck"
)

# lockstep-hackage-managed: true
# lockstep-hackage-deps: begin
HACKAGE_SNAPSHOT="lts-24.56"
HACKAGE_DEPS=(
	"aeson 2.2.5.0 0 adeba3289a7d47a09c45c094c6b28dd0ebd35ffaf1f3cbde12541dadd49974bc"
	"ansi-terminal 1.1.5 0 408d9232e5304efead718f96138d6d7eb2da608c6121c5c0dc6a71a833b14320"
	"ansi-terminal-types 1.1.3 0 1d6061eceaf35a9ed269b81177dd4c8c60403a499526f7f68fdffa4ec7842e7f"
	"assoc 1.1.1 2 766b1040eda5255bfcf10e1a9859c06d0ed6ad0e2ac87ed915bb035574d10ae4"
	"base-orphans 0.9.4 0 001f2b3094b7a1b00e9fd5dcc519a62b8b147a1754bf550fa42601ff868e2b65"
	"bifunctors 5.6.3 1 58f1d66db71ed9dd70648eaca1a0986b29354b3a69b5bfd729ce1a896766466e"
	"call-stack 0.4.0 0 ac44d2c00931dc20b01750da8c92ec443eb63a7231e8550188cb2ac2385f7feb"
	"character-ps 0.1 0 b38ed1c07ae49e7461e44ca1d00c9ca24d1dcb008424ccd919916f92fd48d9fe"
	"code-page 0.2.1 0 fe596b0f421abd2894fdb7049b3d76230eb1de6e04e9f635e2695dd55ded856e"
	"colour 2.3.7 0 613dc8d5f6e51babe57398a742ab8d5c2964fa98b773f3bf6e6a72b7e87f1c6e"
	"comonad 5.0.10 0 e8606e010e306f41019026e94b0676993c175260d1d8908e4518b2b06a40272b"
	"contravariant 1.5.6 0 288f1d3e6fb3adcf9f36f28ffa189673f2f1303812296dfb2523478ad31dd9e2"
	"data-fix 0.3.4 2 200360c49cc81cf8b8bbdf49afd4aee03fffd09d3395b080a7e7c65fcf01d313"
	"Diff 1.0.2 0 39d55f9d86e54939b7cf443fb3a3970d98341073dfda7d52cfa9bc6562f139d9"
	"distributive 0.6.3 0 9dec7cd4dc49325f551b2f2bf2004cfe2454b211e5882265cc87880d4382b1f8"
	"dlist 1.0 2 854727594c5a816ab3d10f15b1bc4fedaf9e3f7d1ef517a2bb9011f29ba261d2"
	"doctest 0.24.3 0 7f1101510233afbab56e92f4198141abce400b9bba344b2edba839c817820d30"
	"fgl 5.8.3.1 0 ba3591561e4005c87bf3d1295ee87e649c2b4c29d6617398fc9a1878389e0981"
	"ghc-paths 0.1.0.12 8 424d50a2a38c6ff5b8454ede5da7fb46ea5370c2d9e1886c480a514223c0b0fa"
	"hashable 1.5.1.0 0 140fc5adad166f7b527567cbd26ff481e8da4a66bdfc84be3ddf28dbeb66f275"
	"indexed-traversable 0.1.5 0 f0b1b514dfc085281d0b4b9338fc0bd0c1d25ee77306f2a144ffe012b0afef8c"
	"indexed-traversable-instances 0.1.2.1 0 76460d05cc3933a21962c7744400d2594144c00badc23c8f8a7d5dfbd39bbe6e"
	"inspection-testing 0.6.3 0 6c274af2e286d1676a177f77618431521dac60c4c2882be80b864816d4b2836f"
	"integer-conversion 0.1.1 2 123d1b088404f0976500c68d8105978aa2e32908ce5508e32aebd237f0447c9f"
	"integer-logarithms 1.0.5 0 870ce80a2e704f179bcda12ee106389a484100fac1534abfd587aaaa51978e6b"
	"network-uri 2.6.4.2 1 6fffb57373962b5651a2db8b0af732098b3bf029a7ced76a9855615de2026588"
	"OneTuple 0.4.3 0 0f5620933850a78b849c0988cbfc2288ab3274b89084bf6681f514143d3f822a"
	"optparse-applicative 0.18.1.0 1 f30973861ac7e7ebff05ff8c7c3d1e4d283a1f3850e1cc14106b0693ec1b6d82"
	"prettyprinter 1.7.2 0 e3a802ea939d465b2e37b9fa09d8e5bb88b5775d6d62dd2ec6ca32b63416656d"
	"prettyprinter-ansi-terminal 1.1.4 0 5184ba6002a650de3307547347eaba19bdc9b82eb68e943f406818caa215ce4f"
	"primitive 0.9.1.0 1 756b222c715bc6ef5ba81fa69cdbaa20c5c53beb6f16f174b8bacc93a6d239f0"
	"QuickCheck 2.15.0.1 1 0cfd337bb9e6fbf09255bd24bb498a156f1d9bcd465396ac8657b25034b9ee31"
	"random 1.2.1.3 0 117541ba0a177397a3333f94870f789ef050dca31b0688a19824b2bc401b8823"
	"regex-base 0.94.0.3 0 d6c0c6d1136f5046207a331114ff4130e70640452096de7719bf03e3fceb7c7b"
	"regex-tdfa 1.3.2.6 0 66a392fba256bc48c90d427af91809eb785ddc526fd2deefd93cc583bd41bbae"
	"scientific 0.3.8.1 0 11b0c3bcc572f08ddcb13bfad94df85e0323f39915e74cae2d7a205c631b4d30"
	"semialign 1.3.1.1 0 e834961b9d22bbd0b6633b644f6005310ca9b883f5c2b3ed216340f946f16a27"
	"semigroupoids 6.0.2 1 52c5a346fdf74380618f67ff784989ef9078498dbbdff09e4d8e2fed20202e2c"
	"splitmix 0.1.3.2 0 a557cff65eed1f70f3a3b468423cd58e7a9a9564c5cc00c76a13de64dec9bcbd"
	"StateVar 1.2.2 0 3c022c00485fe165e3080d5da6b3ca9c9b02f62c5deebc584d1b3d1309ce673e"
	"strict 0.5.1 1 58c373b7c7748cbb4a5a6c8c15073f99a1c10a9a9bb6894ac33f43a5cdb901f2"
	"syb 0.7.2.4 0 936d5a92084ad9d88c5a9dd2e622deab57ce48ce85be93e6273b3f8eb64c12ca"
	"tagged 0.8.9 0 6aad7d2fd594bd51834450d97850b9959305951993ea739fa2bbc18b55d8767d"
	"tasty 1.5.4 0 49f8307d78c7d6b1959d4448152858efe102ca5e9b289be082b9bf221e798084"
	"tasty-bench 0.4.1 1 c38a77747f14e8d26ca99869b879ee56099b04e5381a74a62255dcbab85aab84"
	"tasty-hunit 0.10.2 0 22bc1122e8256664d7cb1e44c6bcace95676c523179947bf2403db71af43dc6d"
	"tasty-inspection-testing 0.2.1 3 dbe49b066f9ca40811ddb70232a129b53c4bfc201763608cb7722d20309a7cbf"
	"tasty-quickcheck 0.11.1 5 12ea6b6fecccc146b69aac3c4810fd5d135564245e9c0708df9b24071a8b0588"
	"temporary 1.3 0 3a66c136f700dbf42f3c5000ca93e80b26dead51e54322c83272b236c1ec8ef1"
	"text-iso8601 0.1.1.1 0 962ea0c5d84580df13bfa50ea940046b9a5f0e4c53afc65267906fa2bc096b96"
	"text-short 0.1.6.1 0 330b037a4f74c069e1ecfe0908baf8fb526526ef35f47922bd67ae2b3d886864"
	"th-abstraction 0.7.2.0 0 380819d6e14645bf66af99b6ea3d3d4309c523c7d0ee376e0678042622f1c272"
	"th-compat 0.1.7 0 449be09a4e3f46ea4645700c026624c4b6f066f508187326c284dbdea8884bc9"
	"these 1.2.1 3 ba1aec9a502eb2b3f90ef254f420468a3c4e5b9b7e8324e3ddc7035143c92640"
	"time-compat 1.9.9 1 0c291e0c3c87ee08b2517107b62901b102a040dc86203b53bdf07a96ff5632e0"
	"transformers-compat 0.7.2 0 044fb9955f63ee138fcebedfdcbe54afe741f2d5892a2d0bdf3a8052bd342643"
	"unordered-containers 0.2.20.1 0 e2ee0d7d8f19747d8c4a0f0a3aa617b1ce1317abd2904c743c04fda25feec685"
	"uuid-types 1.0.6.1 0 95e5bc79e3503c9bd7e68f0c7639400744c824074a0a2e0e4c7438a21c8c4d4f"
	"vector 0.13.2.0 5 3ec12de580ee31ceac89b314fd00b5057ed40198c0b3d9e9dafa54c1941e6942"
	"vector-stream 0.1.0.1 4 483be6df13c72169a917640589666f9fece7bea9fa13fcd41d052dab37ea289e"
	"witherable 0.5 2 a5600431df5d297f098c322c7fbc2ece804e44ade0bb2022a838de24604d6275"
)

hackage_set_globals
# lockstep-hackage-deps: end

src_compile() {
	hackage_cabal_build exe:shellcheck
	hackage_cabal_list_bin exe:shellcheck > "${T}/shellcheck-bin" || die
}

src_install() {
	dobin "$(cat "${T}/shellcheck-bin")"
	einstalldocs
}
