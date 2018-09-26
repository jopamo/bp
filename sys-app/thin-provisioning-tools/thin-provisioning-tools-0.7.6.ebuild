# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic

DESCRIPTION="A suite of tools for thin provisioning on Linux"
HOMEPAGE="https://github.com/jthornber/thin-provisioning-tools"
SRC_URI="https://github.com/jthornber/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static test"

LIB_DEPEND="lib-dev/expat[static-libs(+)]
	lib-dev/libaio[static-libs(+)]"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
# || ( ) is a non-future proof workaround for Portage unefficiency wrt #477050
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	test? (
		|| ( dev-lang/ruby:2.9 dev-lang/ruby:2.8 dev-lang/ruby:2.7 dev-lang/ruby:2.6 dev-lang/ruby:2.5 dev-lang/ruby:2.4 dev-lang/ruby:2.3 dev-lang/ruby:2.2 dev-lang/ruby:2.1 )
		>=dev-cpp/gmock-1.6
		>=dev-cpp/gtest-1.6
		dev-util/cucumber
		dev-util/aruba
	)
	lib-dev/boost"

PATCHES=(
	"${FILESDIR}"/${PN}-0.7.0-build-fixes.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable test testing)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake unit-test
}

src_install() {
	emake DESTDIR="${D}" DATADIR="${ED%/}/usr/share" install
}
