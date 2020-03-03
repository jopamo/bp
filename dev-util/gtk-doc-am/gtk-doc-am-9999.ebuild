# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Automake files from gtk-doc"
HOMEPAGE="https://www.gtk.org/gtk-doc/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk-doc.git"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=dev-lang/perl-5.18"
DEPEND="${RDEPEND}
	dev-util/pkgconf
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
