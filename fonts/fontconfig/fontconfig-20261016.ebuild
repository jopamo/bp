# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SNAPSHOT=ebec29cb759cca828c3ffc043033f470e0af8367
SRC_URI="https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/${SNAPSHOT}/fontconfig-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/fontconfig-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+debug"

DEPEND="
	lib-core/expat
	xgui-lib/freetype
"
RDEPEND="${DEPEND}"
BDEPEND=">=app-dev/meson-1.11.0"

RESTRICT="nostrip"

PATCHES=(
	"${FILESDIR}/0001-keep-mutable-heap-references-as-pointers.patch"
	"${FILESDIR}/0002-tests-use-a-typed-filter-destructor.patch"
)

src_configure() {
	local emesonargs=(
		-Dbuildtype=$(usex debug debug release)
		-Dstrip=$(usex debug false true)
		-Dxml-backend=expat
	)

	if use debug ; then
		filter-lto
		filter-flags -O3 -O2
		append-flags -Og -g -fno-omit-frame-pointer
	fi

	meson_src_configure
}

src_install() {
	meson_src_install
	rmdir "${ED}"/var/cache/fontconfig "${ED}"/var/cache "${ED}"/var ||
		die "expected empty runtime cache directories"
}
