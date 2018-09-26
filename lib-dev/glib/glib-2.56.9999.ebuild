# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-r1 git-r3 multilib-minimal multilib meson

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://github.com/GNOME/${PN}.git"
EGIT_BRANCH=glib-2-56

LICENSE="LGPL-2+"
SLOT="2"
SONAME="2"
IUSE="debug kernel_linux mime selinux static-libs utils xattr libmount internal_pcre docs dtrace systemtap static-libs"
REQUIRED_USE="
	utils? ( ${PYTHON_REQUIRED_USE} )
"

#KEYWORDS="amd64 arm64 x86"

RDEPEND="
	>=lib-dev/libpcre-8.13:3
	kernel_linux? ( sys-app/util-linux )
	selinux? ( >=lib-sys/libselinux-2.2.2-r5 )
	xattr? ( >=sys-app/attr-2.4.47-r1 )
	utils? (
		${PYTHON_DEPS}
		virtual/libelf:0=
	)
"
DEPEND="
	lib-dev/libxslt
	>=app-text/docbook-xml-dtd-4.5
	>=app-text/docbook-xsl-stylesheets-1.79.1
"

src_prepare() {
	multilib_copy_sources
	default
}

src_configure() {
        local emesonargs=(
                $(meson_use selinux)
                $(meson_use xattr)
                $(meson_use libmount)
                $(meson_use internal_pcre)
                $(meson_use docs)
                $(meson_use dtrace)
                $(meson_use systemtap)
                -Dgtk_doc=false
        )
        meson_src_configure
}
