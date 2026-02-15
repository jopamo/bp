# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 python-utils-r1

DESCRIPTION="Automake files from gtk-doc"
HOMEPAGE="https://www.gtk.org/gtk-doc/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk-doc"
SNAPSHOT=48b3c0bde4a3028b2153ddc220ca37a1ca584b67
SRC_URI="https://gitlab.gnome.org/GNOME/gtk-doc/-/archive/${SNAPSHOT}/gtk-doc-${SNAPSHOT}.tar.bz2 -> gtk-doc-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${P}"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=app-lang/perl-5.18"
DEPEND="${RDEPEND}
	app-dev/pkgconf
"
# This ebuild doesn't even compile anything, causing tests to fail when updating (bug #316071)
RESTRICT="test"

src_configure() {
	# Replicate AC_SUBST
	sed -e "s:@PYTHON@:${PYTHON}:g" -e "s:@PYTHON@:${PV}:g" \
		"${S}/gtkdoc-rebase.in" > "${S}/gtkdoc-rebase" || die "sed failed!"
}

src_compile() {
	:
}

src_install() {
	insinto /usr/share/aclocal
	doins buildsystems/autotools/gtk-doc.m4
}
