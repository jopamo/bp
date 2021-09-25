# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Locale program for musl libc"
HOMEPAGE="https://github.com/rilian-la-te/musl-locales"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/rilian-la-te/musl-locales.git"
	inherit git-r3
else
	SNAPSHOT=76fcf3c822b77a987657f0832c873c465b842438
	SRC_URI="https://github.com/rilian-la-te/musl-locales/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 arm64"
