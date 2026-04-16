# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=1744df928dd46a41f91c24282bc996518ee86aa0

inherit flag-o-matic qa-policy gl

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

SRC_URI+=" ${GL_SRC_URI}"

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
	"${FILESDIR}"/${PN}-3.4-posix-printf.patch
	"${FILESDIR}"/${PN}-3.6-tests-unicode.patch
	"${FILESDIR}"/${PN}-3.6-tests-non-bash.patch
)

src_prepare() {
	gl_stage_gnulib
	#cd gnulib
	#git reset --hard 0a12fa9
	#cd ..

	# We do not ship localized manpages; skip po4a-driven doc subdirs.
	sed -i -E 's/^SUBDIRS = .*/SUBDIRS = C/' doc/Makefile.am || die

	default

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die

	filter-flags -Wl,-z,defs -flto\=\*
}

src_configure() {
	qa-policy-configure
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

src_install() {
	default
	qa-policy-install
}
