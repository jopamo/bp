# Distributed under the terms of the GNU General Public License v2

MESON_OPTIONAL=1
inherit meson qa-policy

DESCRIPTION="a program which helps to configure compiler and linker flags for development libraries"
HOMEPAGE="https://git.sr.ht/~kaniini/pkgconf"
SNAPSHOT=d81b4731d6efb33ad971a7936be449d705bb1ae9
SRC_URI="https://github.com/pkgconf/pkgconf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pkgconf-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="build static-libs"
REQUIRED_USE="build? ( !static-libs )"

RESTRICT="!build? ( test )"

BDEPEND="!build? ( ${MESON_DEPEND} )"

src_prepare() {
	default
	if use build; then
		sed -i \
			-e 's/^CPPFLAGS =/override CPPFLAGS +=/' \
			-e 's/${CFLAGS} ${STATIC} -o/${CFLAGS} ${STATIC} ${LDFLAGS} -o/' \
			Makefile.lite || die
	fi
}

src_configure() {
	qa-policy-configure
	use build && return

	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)

	meson_src_configure
}

pkgconf_lite_make() {
	emake -f Makefile.lite \
		CC="$(tc-getCC)" STRIP=true \
		SYSTEM_LIBDIR="${EPREFIX}/usr/lib" \
		SYSTEM_INCLUDEDIR="${EPREFIX}/usr/include" \
		PKG_DEFAULT_PATH="${EPREFIX}/usr/lib/pkgconfig:${EPREFIX}/usr/share/pkgconfig" \
		"$@"
}

src_compile() {
	if use build; then
		pkgconf_lite_make
	else
		meson_src_compile
	fi
}

src_test() {
	if use build; then
		pkgconf_lite_make check
	else
		meson_src_test
	fi
}

src_install() {
	if use build; then
		newbin pkgconf-lite pkgconf
		insinto /usr/share/aclocal
		doins pkg.m4
	else
		meson_src_install
	fi
	dosym -r /usr/bin/pkgconf /usr/bin/pkg-config
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
