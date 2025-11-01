# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=f124ddb0a2cd950d4a94fd99af1313dd6c283d75

inherit flag-o-matic autotools

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="https://www.gnu.org/software/parted"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/parted"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/parted/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug device-mapper nls readline static-libs"

RESTRICT="test"

DEPEND="
	app-fs/e2fsprogs
	device-mapper? ( app-fs/lvm2 )
	readline? ( lib-core/readline virtual/curses )
	nls? ( app-build/gettext )
"

PATCHES=(
	"${FILESDIR}"/${PN}-3.2-po4a-mandir.patch
	"${FILESDIR}"/${PN}-3.3-atari.patch
	"${FILESDIR}"/${PN}-3.4-posix-printf.patch
	"${FILESDIR}"/${PN}-3.6-tests-unicode.patch
	"${FILESDIR}"/${PN}-3.6-tests-non-bash.patch
)

src_prepare() {
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib
	#cd gnulib
	#git reset --hard 0a12fa9
	#cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	default
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die

	filter-flags -Wl,-z,defs -flto\=\*
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		--disable-device-mapper
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with readline)
		--disable-rpath
		--disable-silent-rules
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
