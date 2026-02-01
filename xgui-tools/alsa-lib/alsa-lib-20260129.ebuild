# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
SNAPSHOT=5f7fe33002d2d98d84f72e381ec2cccc0d5d3d40
SRC_URI="https://github.com/alsa-project/alsa-lib/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/alsa-lib-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ucm"

DEPEND="ucm? ( xmedia-app/alsa-ucm-conf )"

src_prepare() {
	use elibc_musl && cp "${FILESDIR}"/ucm_exec.c src/ucm/
	default
	eautoreconf
}

src_configure() {
	filter-flags -flto*

	local myconf=(
		$(use_enable ucm)
		$(use_with debug)
		--disable-maintainer-mode
		--disable-python
		--disable-resmgr
		--disable-aload
		--enable-mixer
		--enable-pcm
		--enable-rawmidi
		--enable-seq
		--enable-shared
		--enable-topology
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
