# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Self-contained, header-only C JSON tokenizer"
HOMEPAGE="https://github.com/jopamo/jstok"
SNAPSHOT=569e5fcc8d3e2634a0a05f858e5bcf8209a272d8
SRC_URI="https://github.com/jopamo/jstok/archive/${SNAPSHOT}.tar.gz -> jstok-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jstok-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
