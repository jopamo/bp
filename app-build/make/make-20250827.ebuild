# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic libtool

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="https://www.gnu.org/software/make/make.html"

SNAPSHOT=c072587a609db822697f05b81316bdb862678282
SRC_URI="https://github.com/1g4-mirror/make/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="
	core-perl/libintl-perl
	app-build/texinfo
"

src_prepare() {
	rm -rf gnulib || die
	cp -a "${BROOT}"/usr/share/gnulib gnulib || die

	#if [[ -d gnulib/.git ]]; then
	#	git -C gnulib reset --hard 6fd6098 || die
	#else
	#	die "BROOT:/usr/share/gnulib is not a git checkout, cannot reset"
	#fi

	echo "${PV}" > .tarball-version || die
	
	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib
	./autogen.sh || die

	default
	elibtoolize "${WORKDIR}"
	
	eapply "${FILESDIR}"/getopt-gcc15.patch
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--without-guile
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
