# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Build infrastructure for GObject Introspection"
HOMEPAGE="https://wiki.gnome.org/Projects/GObjectIntrospection"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gobject-introspection.git"
	inherit git-r3
	EGIT_BRANCH=gnome-3-36
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=dd231b0faf587ff4e0e77519f724214e5876d5c2
	SRC_URI="https://gitlab.gnome.org/GNOME/gobject-introspection/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/gobject-introspection-${SNAPSHOT}
fi

LICENSE="HPND"
SLOT="0"

RDEPEND="!<${CATEGORY}/${PN/-common}-${PV}"

src_configure() { :; }

src_compile() { :; }

src_install() {
	dodir /usr/share/aclocal
	insinto /usr/share/aclocal
	doins m4/introspection.m4

	dodir /usr/share/gobject-introspection-1.0
	insinto /usr/share/gobject-introspection-1.0
	doins Makefile.introspection
}
