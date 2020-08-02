# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for various service managers"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="amdgpu clang"

RDEPEND="
	|| (
		amdgpu? ( amd/llvm-roc[clang?] )
		!amdgpu? ( sys-devel/llvm[clang?] )
	)"
