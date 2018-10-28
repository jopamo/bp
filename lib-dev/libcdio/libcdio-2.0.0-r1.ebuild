# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools libtool multilib-minimal

DESCRIPTION="A library to encapsulate CD-ROM reading and control"
HOMEPAGE="https://www.gnu.org/software/libcdio/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/18" # subslot is based on SONAME
KEYWORDS="amd64 arm64 x86"

IUSE="cddb +cxx minimal static-libs test"

RDEPEND="
	!minimal? (
		>=lib-sys/ncurses-5.7-r7:0=
	)
"
DEPEND="${RDEPEND}
	sys-app/sed
	sys-devel/gettext
	test? ( dev-lang/perl )
"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/cdio/cdio_config.h
	/usr/include/cdio/version.h
)

PATCHES=( "${FILESDIR}/${P}-iso-ioleak.patch" )

src_prepare() {
	default

	eautoreconf

	sed \
		-e "s:-lncurses:$($(tc-getPKG_CONFIG) --libs ncurses):g" \
		-i configure || die

	elibtoolize # to prevent -L/usr/lib ending up in the linker line wrt 499510
}

multilib_src_configure() {
	local util_switch
	if ! multilib_is_native_abi || use minimal ; then
		util_switch="--without"
	else
		util_switch="--with"
	fi

	# Tests fail if ECONF_SOURCE is not relative
	ECONF_SOURCE="../${P}" econf \
		--disable-maintainer-mode \
		$(use_enable cxx) \
		--disable-cpp-progs \
		--disable-example-progs \
		$(use_enable static-libs static) \
		$(use_enable cddb) \
		--disable-vcd-info \
		${util_switch}-{cd-drive,cd-info,cdda-player,cd-read,iso-info,iso-read}
}

multilib_src_install_all() {
	einstalldocs
	find "${ED}" -name '*.la' -delete || die
}
