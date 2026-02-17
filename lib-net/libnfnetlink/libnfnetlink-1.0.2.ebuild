# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qa-policy

DESCRIPTION="the low-level library for netfilter related kernel/userspace communication"
HOMEPAGE="http://www.netfilter.org/projects/libnfnetlink/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"
BDEPEND="app-dev/patchelf"

src_prepare() {
	default
}

src_configure() {
	qa-policy-configure

	econf $(use_enable static-libs static)
}

src_install() {
	default

	qa-policy-install
}
