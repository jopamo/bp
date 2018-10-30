# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib

DESCRIPTION="C++ BitTorrent implementation focusing on efficiency and scalability"
HOMEPAGE="http://libtorrent.org"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/arvidn/libtorrent.git"
else
	inherit versionator
	MY_PV=$(replace_all_version_separators _)
	SRC_URI="https://github.com/arvidn/libtorrent/archive/libtorrent-${MY_PV}.tar.gz"
	S=${WORKDIR}/${PN}-${PN}-${MY_PV}
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="BSD"
SLOT="0/9"
IUSE="static-libs"

RDEPEND="
	lib-dev/boost
	lib-dev/openssl
"
DEPEND="${RDEPEND}
	sys-devel/libtool
"

src_prepare() {
	append-cxxflags -lboost_system
	cmake-utils_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=(
					-Dshared=ON
					-Dstatic_runtime=OFF
					-Dencryption=ON
					-Ddht=ON
					-Ddeprecated-functions=OFF
					-Dexceptions=ON
					-Dlogging=OFF
					-Dbuild_tests=OFF
					)

	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

multilib_src_install() {
	cmake-utils_src_install
	use static-libs || rm -f "${ED}"usr/$(get_libdir)/libssh{,_threads}.a
}
