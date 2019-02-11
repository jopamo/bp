# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils qmake-utils xdg-utils

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks"
HOMEPAGE="http://fixounet.free.fr/avidemux"
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
SLOT="2.7"
IUSE="debug nls nvenc opengl sdl xv"

if [[ ${PV} == *9999* ]] ; then
	MY_P="${P}"
	EGIT_REPO_URI="https://github.com/mean00/avidemux2.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	MY_P="${PN}_${PV}"
	SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${MY_P}.tar.gz"
fi

COMMON_DEPEND="
	~lib-media/avidemux-core-${PV}:${SLOT}[nls?,sdl?,xv?,nvenc?]
	nvenc? ( amd64? ( app-media/nvidia_video_sdk:0 ) )
	opengl? ( lib-media/mesa:0 )
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtopengl:5
	gui-lib/qtwidgets:5
"

DEPEND="${COMMON_DEPEND}
	gui-lib/linguist-tools:5
"
RDEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext:0 )
	!<app-media/avidemux-${PV}
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	processes="buildCli:avidemux/cli"

	for process in ${processes} ; do
		CMAKE_USE_DIR="${S}"/${process#*:} cmake-utils_src_prepare
	done

	# Fix icon name -> avidemux-2.7.png
	sed -i -e "/^Icon/ s:${PN}:${PN}-${SLOT}:" ${PN}2.desktop || \
		die "Icon name fix failed."

	# The desktop file is broken. It uses avidemux2 instead of avidemux3
	# so it will actually launch avidemux-2.7 if it is installed.
	sed -i -e "/^Exec/ s:${PN}2:${PN}3:" ${PN}2.desktop || \
		die "Desktop file fix failed."

	# QA warnings: missing trailing ';' and 'Application' is deprecated.
	sed -i -e 's/Application;AudioVideo/AudioVideo;/g' ${PN}2.desktop || \
		die "Desktop file fix failed."

	# Now rename the desktop file to not collide with 2.6.
	mv ${PN}2.desktop ${PN}-${SLOT}.desktop || die "Collision rename failed."

	# Remove "Build Option" dialog because it doesn't reflect
	# what the GUI can or has been built with. (Bug #463628)
	sed -i -e '/Build Option/d' avidemux/common/ADM_commonUI/myOwnMenu.h || \
		die "Couldn't remove \"Build Option\" dialog."
}

src_configure() {
	# The build relies on an avidemux-core header that uses 'nullptr'
	# which is from >=C++11. Let's use the GCC-6 default C++ dialect.
	append-cxxflags -std=c++14

	local mycmakeargs=(
		-DGETTEXT="$(usex nls)"
		-DSDL="$(usex sdl)"
		-DXVIDEO="$(usex xv)"
	)

	if use debug ; then
		mycmakeargs+=( -DVERBOSE=1 -DADM_DEBUG=1 )
	fi

	for process in ${processes} ; do
		local build="${WORKDIR}/${P}_build/${process%%:*}"
		CMAKE_USE_DIR="${S}"/${process#*:} BUILD_DIR="${build}" cmake-utils_src_configure
	done
}

src_compile() {
	for process in ${processes} ; do
		local build="${WORKDIR}/${P}_build/${process%%:*}"
		BUILD_DIR="${build}" cmake-utils_src_compile
	done
}

src_test() {
	for process in ${processes} ; do
		local build="${WORKDIR}/${P}_build/${process%%:*}"
		BUILD_DIR="${build}" cmake-utils_src_test
	done
}

src_install() {
	for process in ${processes} ; do
		local build="${WORKDIR}/${P}_build/${process%%:*}"
		BUILD_DIR="${build}" cmake-utils_src_install
	done

	if [[ -f "${ED}"/usr/bin/avidemux3_cli ]] ; then
		fperms +x /usr/bin/avidemux3_cli
	fi

	if [[ -f "${ED}"/usr/bin/avidemux3_jobs ]] ; then
		fperms +x /usr/bin/avidemux3_jobs
	fi

	cd "${S}" || die "Can't enter source folder."
	newicon ${PN}_icon.png ${PN}-${SLOT}.png

	if [[ -f "${ED}"/usr/bin/avidemux3_qt5 ]] ; then
		fperms +x /usr/bin/avidemux3_qt5
	fi

	if [[ -f "${ED}"/usr/bin/avidemux3_jobs_qt5 ]] ; then
		fperms +x /usr/bin/avidemux3_jobs_qt5
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
