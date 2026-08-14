# Distributed under the terms of the GNU General Public License v2

inherit git-r3

DESCRIPTION="Tool to create a minimal Debian/Ubuntu root filesystem from scratch"
HOMEPAGE="https://salsa.debian.org/installer-team/debootstrap.git"
EGIT_REPO_URI="https://salsa.debian.org/installer-team/debootstrap.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i 's/sbin/bin/g' Makefile || die
}

src_compile() {
	:
}

src_test() {
	local script
	for script in debootstrap functions scripts/*; do
		[[ -f ${script} ]] || continue
		sh -n "${script}" || die "shell syntax check failed for ${script}"
	done

	local test_dir="${T}/debootstrap-data"
	mkdir -p "${test_dir}/scripts" || die
	cp functions "${test_dir}/" || die
	cp -a scripts/. "${test_dir}/scripts/" || die

	DEBOOTSTRAP_DIR="${test_dir}" sh ./debootstrap --version || die
}

src_install() {
	emake DESTDIR="${D}" install
	doman debootstrap.8
}
