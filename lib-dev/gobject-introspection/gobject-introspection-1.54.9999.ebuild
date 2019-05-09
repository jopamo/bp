# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit python-single-r1 toolchain-funcs versionator autotools flag-o-matic

DESCRIPTION="Introspection system for GObject-based libraries"
HOMEPAGE="https://wiki.gnome.org/Projects/GObjectIntrospection"
EGIT_REPO_URI="https://github.com/GNOME/gobject-introspection.git"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/GNOME/gobject-introspection.git"
	inherit git-r3
	EGIT_BRANCH=gnome-3-26
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=dd231b0faf587ff4e0e77519f724214e5876d5c2
	SRC_URI="https://github.com/GNOME/gobject-introspection/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2+ GPL-2+"
SLOT="0"
IUSE="cairo doctool test"

RDEPEND="
	>=lib-dev/gobject-introspection-common-${PV}
	lib-dev/glib
	doctool? ( dev-python/mako[${PYTHON_USEDEP}] )
	lib-dev/libffi
	dev-util/pkgconf
	!<dev-lang/vala-0.20.0
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.19
	sys-devel/bison
	sys-devel/flex
"
PDEPEND="cairo? ( x11-libs/cairo[glib] )"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	${S}/autogen.sh
	eautoreconf
	default
}

src_configure() {
	if ! has_version "x11-libs/cairo[glib]"; then
		# Bug #391213: enable cairo-gobject support even if it's not installed
		# We only PDEPEND on cairo to avoid circular dependencies
		export CAIRO_LIBS="-lcairo -lcairo-gobject"
		export CAIRO_CFLAGS="-I${EPREFIX}/usr/include/cairo"
	fi

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-static
		CC="$(tc-getCC)"
		YACC="$(type -p yacc)"
		$(use_with cairo)
		$(use_enable doctool)
	)
	econf ${myconf[@]}
}

src_install() {
	default

	# Prevent collision with gobject-introspection-common
	rm -v "${ED}"usr/share/aclocal/introspection.m4 \
		"${ED}"usr/share/gobject-introspection-1.0/Makefile.introspection || die
	rmdir "${ED}"usr/share/aclocal || die
}
