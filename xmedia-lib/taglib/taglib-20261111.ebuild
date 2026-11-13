# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="https://taglib.github.io/"
SNAPSHOT=58499cb157c38b8d07b262b15c4ecba9f36aeb9a
UTFCPP_SNAPSHOT=2d8e20b22dcb3e9b3c4f52103182ebda949c6089
# lockstep-gitlink: UTFCPP_SNAPSHOT SNAPSHOT 3rdparty/utfcpp
SRC_URI="
	https://github.com/taglib/taglib/archive/${SNAPSHOT}.tar.gz -> taglib-${SNAPSHOT}.tar.gz
	https://github.com/nemtrif/utfcpp/archive/${UTFCPP_SNAPSHOT}.tar.gz -> utfcpp-${UTFCPP_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/taglib-${SNAPSHOT}"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND=">=lib-dev/cppunit-1.14.0"

src_unpack() {
	default
	rmdir "${S}/3rdparty/utfcpp" || die
	mv "${WORKDIR}/utfcpp-${UTFCPP_SNAPSHOT}" "${S}/3rdparty/utfcpp" || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_REQUIRE_FIND_PACKAGE_CppUnit=ON
	)
	cmake_src_configure
}
