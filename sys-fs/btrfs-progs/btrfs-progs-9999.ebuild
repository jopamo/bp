# Distributed under the terms of the GNU General Public License v2

EAPI=7

libbtrfs_soname=0

if [[ ${PV} != 9999 ]]; then
	MY_PV=v${PV}
	KEYWORDS="amd64 arm64"
	SRC_URI="https://www.kernel.org/pub/linux/kernel/people/kdave/${PN}/${PN}-${MY_PV}.tar.xz"
	S="${WORKDIR}"/${PN}-${MY_PV}
else
	WANT_LIBTOOL=none
	inherit autotools git-r3
	EGIT_REPO_URI="https://github.com/kdave/btrfs-progs.git"
	EGIT_BRANCH="devel"
fi

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="https://btrfs.wiki.kernel.org"

LICENSE="GPL-2"
SLOT="0/${libbtrfs_soname}"
IUSE="static static-libs"

RESTRICT=test # tries to mount repared filesystems

RDEPEND="lib-dev/lzo:2=
	sys-app/util-linux:0=[static-libs(+)?]
	lib-sys/zlib:0="

DEPEND="${RDEPEND}
	app-compression/zstd
	app-text/docbook-xml-dtd:4.5
	app-text/xmlto
	static? (
		lib-dev/lzo:2[static-libs(+)]
		sys-app/util-linux:0[static-libs(+)]
		lib-sys/zlib:0[static-libs(+)]
		app-compression/zstd:0[static-libs(+)]
	)
"

if [[ ${PV} == 9999 ]]; then
	DEPEND+=" sys-devel/gnuconfig"
fi

src_prepare() {
	default
	if [[ ${PV} == 9999 ]]; then
		AT_M4DIR=m4 eautoreconf
		mkdir config || die
		local automakedir="$(autotools_run_tool --at-output automake --print-libdir)"
		[[ -e ${automakedir} ]] || die "Could not locate automake directory"
		ln -s "${automakedir}"/install-sh config/install-sh || die
		ln -s "${EPREFIX}"/usr/share/gnuconfig/config.guess config/config.guess || die
		ln -s "${EPREFIX}"/usr/share/gnuconfig/config.sub config/config.sub || die
	fi
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-convert
		--disable-documentation
		$(use_enable elibc_glibc backtrace)
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
