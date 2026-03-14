# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qa-policy

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="https://www.gnu.org/software/make/make.html"

SNAPSHOT=c072587a609db822697f05b81316bdb862678282
SRC_URI="https://github.com/1g4-mirror/make/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3+ FDL-1.3+"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="static test"

BDEPEND="
	app-build/autoconf
	app-build/automake
	app-build/gettext
	app-build/gnulib
	app-build/texinfo
	app-dev/pkgconf
	test? ( app-lang/perl )
"

PATCHES=( "${FILESDIR}"/getopt-gcc15.patch )

src_prepare() {
	rm -rf gnulib || die
	cp -a "${BROOT}"/usr/share/gnulib gnulib || die

	echo "${PV}" > .tarball-version || die

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib || die

	default
}

src_configure() {
	qa-policy-configure
	use static && append-ldflags -static

	local myconf=(
		--without-guile
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	use test || return 0

	emake check
}

src_install() {
	default

	qa-policy-install
}
