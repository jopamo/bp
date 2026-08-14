# Distributed under the terms of the GNU General Public License v2

BASEVERSION="17.0.20"

DESCRIPTION="Zulu OpenJDK17"
HOMEPAGE="https://www.azul.com/"

SRC_URI="amd64? ( https://cdn.azul.com/zulu/bin/zulu${PV}-ca-fx-jdk${BASEVERSION}-linux_x64.tar.gz )
		arm64? ( https://cdn.azul.com/zulu/bin/zulu${PV}-ca-jdk${BASEVERSION}-linux_aarch64.tar.gz )"

S="${WORKDIR}"

LICENSE="https://www.azul.com/products/core/openjdk-terms-of-use/"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="preserve-libs strip"

QA_PREBUILT="opt/${PN}/*"

src_unpack() {
	default

	case ${ARCH} in
		amd64)
			S="${WORKDIR}/zulu${PV}-ca-fx-jdk${BASEVERSION}-linux_x64"
			;;
		arm64)
			S="${WORKDIR}/zulu${PV}-ca-jdk${BASEVERSION}-linux_aarch64"
			;;
		*)
			die "Unsupported ARCH=${ARCH}"
			;;
	esac
}

src_compile() { :;}

src_install() {
	HERE="${ED}"/opt/${PN}

	mkdir -p "${HERE}" || die
	cp -rp "${S}"/* "${HERE}"/ || die
	find "${ED}" -type d -empty -delete || die
}
