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

###do the flags
IUSE="debug +dht doc examples libressl +ssl static-libs test"

RDEPEND="
	lib-dev/boost:=[threads]
	ssl? (
		!libressl? ( lib-dev/openssl:0= )
		libressl? ( lib-dev/libressl:= )
	)
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
	multilib_is_native_abi && use doc && cmake-utils_src_compile doc
}

multilib_src_install() {
	cmake-utils_src_install

	use static-libs || rm -f "${ED}"usr/$(get_libdir)/libssh{,_threads}.a

	#multilib ugly
	mv "${ED}"usr/lib "${ED}"usr/$(get_libdir)
}
