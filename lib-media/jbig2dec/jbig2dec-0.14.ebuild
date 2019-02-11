# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal

DESCRIPTION="A decoder implementation of the JBIG2 image compression format"
HOMEPAGE="http://ghostscript.com/jbig2dec.html"
SRC_URI="https://github.com/ArtifexSoftware/jbig2dec/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="png static-libs test"

RDEPEND="png? ( lib-media/libpng:0= )"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e /^autoreconf/d autogen.sh || die
	NOCONFIGURE=1 ${S}/autogen.sh || die
	emake distclean
	eautoreconf
	if use test; then
		mkdir "${WORKDIR}/ubc" || die
		mv -v "${WORKDIR}"/*.jb2 "${WORKDIR}/ubc/" || die
		mv -v "${WORKDIR}"/*.bmp "${WORKDIR}/ubc/" || die
	fi
	eapply_user
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_with png libpng)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
