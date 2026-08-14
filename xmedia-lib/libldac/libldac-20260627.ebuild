# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="A dispatcher for AOSP libldac"
HOMEPAGE="https://github.com/EHfive/ldacBT"

VERSION=2.0.2.6
SRC_URI="https://github.com/EHfive/ldacBT/releases/download/v${VERSION}/ldacBT-${VERSION}.tar.gz -> ldacBT-${VERSION}.tar.gz"
S="${WORKDIR}"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="arm64 amd64"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_INCLUDEDIR=/usr/include
		-DINSTALL_LDAC_INCLUDEDIR=/usr/include/ldac
		-DINSTALL_LIBDIR="/usr/$(get_libdir)"
		-DINSTALL_PKGCONFIGDIR="/usr/$(get_libdir)/pkgconfig"
	)

	qa-policy-configure
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}
