# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils multilib multilib-minimal flag-o-matic

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://git.alsa-project.org/${PN}.git"
else
	SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${P}.tar.bz2"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="alisp debug doc elibc_uclibc"

RDEPEND="abi_x86_32? (
		!<=app-misc/emul-linux-x86-soundlibs-20130224-r1
		!app-misc/emul-linux-x86-soundlibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}
	doc? ( >=app-text/doxygen-1.2.6 )"

filter-flags -flto

multilib_src_configure() {
	local myconf

	use elibc_uclibc && myconf+=" --without-versioned"

	ECONF_SOURCE=${S} \
	econf \
		--disable-maintainer-mode \
		--disable-python \
		--enable-shared \
		--disable-resmgr \
		--enable-rawmidi \
		--enable-seq \
		--enable-aload \
		$(use_with debug) \
		$(use_enable alisp) \
		${myconf}
}
