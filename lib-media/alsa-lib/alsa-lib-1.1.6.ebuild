# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils multilib multilib-minimal

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

multilib_src_compile() {
	emake

	if multilib_is_native_abi && use doc; then
		emake doc
		fgrep -Zrl "${S}" doc/doxygen/html | \
			xargs -0 sed -i -e "s:${S}::"
	fi
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	if multilib_is_native_abi && use doc; then
		docinto html
		dodoc -r doc/doxygen/html/.
	fi
}

multilib_src_install_all() {
	prune_libtool_files --all
	find "${ED}"/usr/$(get_libdir)/alsa-lib -name '*.a' -exec rm -f {} +
	docinto ""
	dodoc ChangeLog doc/asoundrc.txt NOTES TODO
}
