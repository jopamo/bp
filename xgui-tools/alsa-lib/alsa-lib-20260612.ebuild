# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic autotools

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"
SNAPSHOT=f453d783336167ee2714573f4352a72e3ce65094
SRC_URI="https://github.com/alsa-project/alsa-lib/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/alsa-lib-${SNAPSHOT}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ucm"

DEPEND="ucm? ( xmedia-app/alsa-ucm-conf )"

src_prepare() {
	if use elibc_musl; then
		cp "${FILESDIR}"/ucm_exec.c src/ucm/ || die
		eapply "${FILESDIR}"/${PN}-20260504-musl-lfs-compat.patch
	fi
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
