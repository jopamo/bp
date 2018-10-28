# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Oracle's Java SE Runtime Environment"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-Docs.git"

KEYWORDS="amd64"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"

src_prepare() {
	rm "${S}"/Makefile
	default
}
src_install() {
	mkdir -p "${ED}"/usr || die
	cp -pPR	include "${ED}"/usr/ || die
	find "${ED}" -type d -empty -exec rmdir -v {} + || die
}
