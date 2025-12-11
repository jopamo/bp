# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="giflib-turbo - A faster drop-in replacement for giflib"
HOMEPAGE="https://github.com/bitbank2/giflib-turbo"

SNAPSHOT=ca7058b0141c577810fa793458796c485945ed8a
SRC_URI="https://github.com/bitbank2/giflib-turbo/archive/${SNAPSHOT}.tar.gz -> giflib-turbo-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/giflib-turbo-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
