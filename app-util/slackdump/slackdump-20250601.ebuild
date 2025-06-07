# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Save or export your private and public Slack data"
HOMEPAGE="https://github.com/rusq/slackdump"

SNAPSHOT=429b0d4951d21531859e9b71a54d2b0146a6daff
SRC_URI="https://github.com/rusq/slackdump/archive/${SNAPSHOT}.tar.gz -> slackdump-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/slackdump-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	sed -i 's#BUILD=$(shell git describe --tags)#BUILD=${PV}#' Makefile || die
	sed -i 's#COMMIT=$(shell git rev-parse --short HEAD)#COMMIT=${SNAPSHOT}#' Makefile || die
	sed -i 's#ZIPFILES=$(foreach s,$(OSES),$(OUTPUT)-$s.zip)#ZIPFILES=#' Makefile || die
	sed -i '/%.zip:/d' Makefile || die
	sed -i 's#dist:.*#dist: #' Makefile || die

	default
}

src_install() {
	dobin slackdump
}
