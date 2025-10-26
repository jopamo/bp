# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-any-r1 cmake

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile"
SNAPSHOT=d9a35ea0d5c64c19dd635ae578e0028df8f66d6a
SRC_URI="https://github.com/libsndfile/libsndfile/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xmedia-lib/flac
	xmedia-lib/libogg
	xmedia-lib/libvorbis
	xmedia-lib/opus
"
