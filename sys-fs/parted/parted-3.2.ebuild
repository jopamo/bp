# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="https://www.gnu.org/software/parted"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+debug device-mapper nls readline static-libs"
RESTRICT="test"

RDEPEND="
	>=sys-fs/e2fsprogs-1.27
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	readline? ( >=lib-sys/readline-5.2:0= >=lib-sys/ncurses-5.7-r7:0= )"

DEPEND="
	${RDEPEND}
	nls? ( >=sys-devel/gettext-0.12.1-r2 )
	dev-util/pkgconfig
"

PATCHES=(	${FILESDIR}/0002-include.patch
			${FILESDIR}/0568d156ea9d06670461f5dfc5d2077f587de8db.patch
			${FILESDIR}/0601c8ea6de92017ee8c6293db102029e309b166.patch
			${FILESDIR}/3262e2fe9ec93ad2c24e1b117bf87fb6f4b6ffec.patch
			${FILESDIR}/9fe7e4a1f676331fafdf4e15c2b02c0ded3df694.patch
			${FILESDIR}/23866318ff15188d784a81b99ed6eeb618254577.patch
			${FILESDIR}/5a02a03e72dc116d5bcab04b8f2185ee2772b967.patch
			${FILESDIR}/a52926f6d3cd2520419c60d4f81a410d33d6d970.patch
			${FILESDIR}/25a19f80a97b4b04d1ada3fdfe45671121886b6d.patch
			${FILESDIR}/b62b3e6757e3e123f4efabdaaafaa85f0464a074.patch
			${FILESDIR}/149f009c3b4ab6bac8059b48142a1c3f698c8e53.patch
			${FILESDIR}/7e87ca3c531228d35e13e802d2622006138b104c.patch
			${FILESDIR}/c624fe22349912ca8bd1a288d5ccc65b6e346420.patch
			${FILESDIR}/4886bad13dd011ff56e1c46ff29e8067778c16fd.patch
			${FILESDIR}/c6dc6e5d0f49a26242d2b28622514814a53d92e1.patch
			${FILESDIR}/50dc0862a94a3e6e77d4cfb2af21de117fbb4819.patch
			${FILESDIR}/a3877115f1956949096d77aca5a703a47ed68397.patch
			${FILESDIR}/d15a596a4436a08b9ad9db35729740b6314d536b.patch
			${FILESDIR}/af150f6764a08eae4b4cf448c392259c067a1523.patch
			${FILESDIR}/b260c3354d5e9318321c2fc482724870fd9b2740.patch
			${FILESDIR}/f5c628dd51c7d77ff939554425159ab6e8aef1c0.patch
			${FILESDIR}/b70ecd7a7ef1f69b0afd5c239681decbf369f5d9.patch
		)

filter-flags -flto -Wl,-z,defs -Wl,-z,relro -Werror

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use elibc_uclibc && append-libs -liconv

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
		$(use_enable device-mapper)
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
	find "${D}" -name '*.la' -delete || die
}
