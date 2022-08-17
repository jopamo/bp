# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg autotools flag-o-matic

DESCRIPTION="Glade is a RAD tool to enable quick & easy development of user interfaces for the GTK+ toolkit and the GNOME desktop environment."
HOMEPAGE="https://gitlab.gnome.org/GNOME/glade"
SRC_URI="https://download.gnome.org/sources/libglade/$(ver_cut 1-2)/lib${P}.tar.bz2"
S=${WORKDIR}/lib${P}

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-lib/gtk+:3
	lib-core/libxml2
"

filter-flags -Wl,-z,defs

src_prepare() {
	eapply "${FILESDIR}"/Makefile.in.am-2.4.2-xmlcatalog.patch

	default
	eautoreconf
}
