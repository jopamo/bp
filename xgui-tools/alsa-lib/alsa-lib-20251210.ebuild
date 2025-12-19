# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
SNAPSHOT=f30c355278cf9c86420b49ab9efc7eee890b658c
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
