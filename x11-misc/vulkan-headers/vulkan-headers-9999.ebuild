# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Vulkan Header files and API registry "
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Docs"
EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-Docs.git"

LICENSE="apache"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_prepare() {
	rm "${S}"/Makefile
	default
}

src_install() {
	insinto usr/include/vulkan/
	doins include/vulkan/*
}
