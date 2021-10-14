# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="No Fee Ethash miner for AMD and Nvidia"
HOMEPAGE="https://github.com/no-fee-ethereum-mining/nsfminer"
EGIT_REPO_URI="https://github.com/no-fee-ethereum-mining/nsfminer.git"

LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	bin/nvidia-cuda
	lib-live/jsoncpp
	lib-dev/boost
	virtual/ssl
"
src_prepare() {
	sed -i \
		-e '/include_directories.+BEFORE/ s:\.\.:& \.:' \
		-e '/find_package.*CLI11/d' \
		-e '/target_link_libraries/ s/CLI11::CLI11//' \
		-e 's/target_link_libraries.*nsfminer.*PRIVATE/& crypto/' \
		-e '/find_package.*PkgConfig/ s/PkgConfig/DBus1 REQUIRED/' \
		-e '/set.*ENV/d' \
		-e '/pkg_check_modules.*DBUS/d' \
		-e '/include_directories.*DBUS_INCLUDE_DIRS/ s/DBUS/DBus1/' \
		-e '/link_directories.*DBUS/d' \
		-e '/target_link_libraries.*DBUS_LIBRARIES/ s/DBUS_LIBRARIES/DBus1_LIBRARY/' \
		nsfminer/CMakeLists.txt || die

	sed -i \
		-e 's/jsoncpp_lib_static/jsoncpp/' \
		libpool/CMakeLists.txt || die

	sed -i \
		-e '/dbusint/ s/str()/str()\.c_str()/' \
		nsfminer/main.cpp || die

	sed -i \
		-e 's/get_io_service()/context()/' \
		libeth/Farm.cpp || die

	sed -i \
		-e '/boost::bind/ s/_1/boost::placeholders::_1/' \
		libpool/getwork/EthGetworkClient.cpp || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS='OFF'
		-DAPICORE='OFF'
        -DETHASHCL='ON'
        -DETHASHCPU='OFF'
        -DETHASHCUDA='ON'
        -DETHDBUS='OFF'
        -DHUNTER_ENABLED='OFF'
        -Wno-dev
	)
	cmake_src_configure
}
