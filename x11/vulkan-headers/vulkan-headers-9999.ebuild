# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Vulkan Header files and API registry "
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Docs"
EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-Docs.git"

KEYWORDS="amd64"

LICENSE="apache"
SLOT="0"

src_prepare() {
	rm "${S}"/Makefile
	default
}

src_install() {
	insinto usr/include/vulkan/
	doins include/vulkan/*
}
