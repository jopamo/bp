# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="Utility to detect other OSs on a set of drives"
HOMEPAGE="https://packages.debian.org/source/sid/os-prober"
SNAPSHOT=9a94fb8c42043b0c9fe8fd3d3a20aa51a81fabbc
SRC_URI="https://salsa.debian.org/installer-team/os-prober/-/archive/${SNAPSHOT}/os-prober-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-core/util-linux[logger]"

src_install() {
	dobin os-prober linux-boot-prober

	exeinto /usr/lib/os-prober
	doexe newns

	insinto /usr/share/os-prober
	doins common.sh

	keepdir /var/lib/os-prober

	local debarch=${ARCH%-*} dir

	case ${debarch} in
		amd64)		debarch=x86 ;;
	esac

	for dir in os-probes{,/mounted,/init} linux-boot-probes{,/mounted}; do
		exeinto /usr/lib/$dir
		doexe $dir/common/*
		if [[ -d $dir/$debarch ]]; then
			doexe $dir/$debarch/*
		fi
		if [[ -d $dir/$debarch/efi ]]; then
			exeinto /usr/lib/$dir/efi
			doexe $dir/$debarch/efi/*
		fi
	done

	if use amd64 ; then
		exeinto /usr/lib/os-probes/mounted
		doexe os-probes/mounted/powerpc/20macosx
	fi
}
