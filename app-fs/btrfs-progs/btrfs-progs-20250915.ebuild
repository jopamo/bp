# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="https://btrfs.wiki.kernel.org"
SNAPSHOT=94c16d5eee442cccb493b6373cf341bea013b50c
SRC_URI="https://github.com/kdave/btrfs-progs/archive/${SNAPSHOT}.tar.gz -> btrfs-progs-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/btrfs-progs-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static static-libs"

RESTRICT=test

LIB_DEPEND="
	app-core/util-linux:0[static-libs(+)]
	lib-core/zlib:0[static-libs(+)]
	app-compression/zstd:0[static-libs(+)]
	app-compression/lzo:0[static-libs(+)]
"

DEPEND="
	static-libs? ( ${LIB_DEPEND} )
	${LIB_DEPEND//\[static-libs\(+\)\]}
	static? ( ${LIB_DEPEND} )
"

if [[ ${PV} == 9999 ]]; then
	DEPEND+=" app-build/gnuconfig"
fi

src_prepare() {
	append-flags -ffat-lto-objects

	default

	eaclocal
	eautoconf
	eautoheader

	local automakedir="$(autotools_run_tool --at-output automake --print-libdir)"
	[[ -e ${automakedir} ]] || die "Could not locate automake directory"
	ln -s "${automakedir}"/install-sh config/install-sh || die
	ln -s "${EPREFIX}"/usr/share/gnuconfig/config.guess config/config.guess || die
	ln -s "${EPREFIX}"/usr/share/gnuconfig/config.sub config/config.sub || die
}

src_configure() {
	local myconf=(
		--disable-convert
		--disable-documentation
		--disable-backtrace
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	emake V=1 all $(usev static)
}

src_install() {
	local makeargs=(
		$(usex static-libs '' 'libs_static=')
		$(usex static install-static '')
	)
	emake V=1 DESTDIR="${D}" install "${makeargs[@]}"
}
