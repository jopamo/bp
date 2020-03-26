# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/qemu/qemu.git"
	inherit git-r3
else
	SRC_URI="http://wiki.qemu-project.org/download/${P}.tar.bz2"
fi

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro
append-flags -Wno-error

src_configure() {
	local myconf=(
		--disable-gtk
		--target-list=x86_64-softmmu,aarch64-softmmu,aarch64-linux-user,x86_64-linux-user
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
