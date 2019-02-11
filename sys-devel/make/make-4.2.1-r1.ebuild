# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic eutils

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="https://www.gnu.org/software/make/make.html"
SRC_URI="mirror://gnu//make/${P}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="guile nls static"

CDEPEND="guile? ( >=dev-scheme/guile-1.8:= )"
DEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )"
RDEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )"

PATCHES=(
	"${FILESDIR}"/${PN}-4.2-default-cxx.patch
	${FILESDIR}/212cb00923606c89a0a00eff445f91405e5e459d.patch
	${FILESDIR}/9c487cc5376b8438d3d4052dedd6bed90f40cd7e.patch
	${FILESDIR}/3d7c17c5a9bc5437968eeeb3a48dd97cb022f264.patch
	${FILESDIR}/80861cce431a835c260bf5c7646c86da5e7bf296.patch
	${FILESDIR}/053d49367c51bcdaa97f6f22188e5b62070c566c.patch
	${FILESDIR}/a359e32eb5b7e6e24c0eb17e31a0711d47027d75.patch
	${FILESDIR}/3daaa4dd3e6bb41841d5ec60ba47f7e4220162f5.patch
	${FILESDIR}/d351c1fef2ec30b69f92163e0572d7d7d7b33db4.patch
	${FILESDIR}/fbf71ec25a5986d9003ac16ee9e23675feac9053.patch
	${FILESDIR}/816a867ff51110cbca1956ad0e625d8251a7531b.patch
	${FILESDIR}/5345adf82f5d57b0d30a3e8ec8e1c68f91382f21.patch
	${FILESDIR}/b552b05251980f693c729e251f93f5225b400714.patch
	${FILESDIR}/66a9b5c3ba4f94342ed1c17cdeb0bbd9df88f72d.patch
	${FILESDIR}/75b5268faf78f7c191f0aafe2250c9ec004659fe.patch
	${FILESDIR}/78b5fec6898c26956d00548427cda1101cb80f8a.patch
	${FILESDIR}/22fd57869383a6ca44f5d3c189c6f629c6929ede.patch
	${FILESDIR}/193f1e81edd6b1b56b0eb0ff8aa4b41c7b4257b4.patch
	${FILESDIR}/b9c25de370ccb18716cf21e38009f42d54979ddc.patch
	${FILESDIR}/ef7a1b7d6e276b0c3a08c28fbfab7752704cb20c.patch
	${FILESDIR}/0c44ca26830e29b9de8297719bc2bd05c16bf8f6.patch
	${FILESDIR}/1af314465e5dfe3e8baa839a32a72e83c04f26ef.patch
	${FILESDIR}/48c8a116a914a325a0497721f5d8b58d5bba34d4.patch
)

src_configure() {
	use static && append-ldflags -static
	econf \
		--program-prefix=g \
		$(use_with guile) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install

	if [[ ${USERLAND} == "GNU" ]] ; then
		# we install everywhere as 'gmake' but on GNU systems,
		# symlink 'make' to 'gmake'
		dosym gmake /usr/bin/make
		dosym gmake.1 /usr/share/man/man1/make.1
	fi
}
