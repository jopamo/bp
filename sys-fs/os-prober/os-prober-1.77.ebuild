# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utility to detect other OSs on a set of drives"
HOMEPAGE="https://packages.debian.org/source/sid/os-prober"
SRC_URI="http://http.debian.net/debian/pool/main/o/${PN}/${PN}_${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

QA_MULTILIB_PATHS="usr/lib/os-prober/.*"

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

	if use amd64 || use x86; then
		exeinto /usr/lib/os-probes/mounted
		doexe os-probes/mounted/powerpc/20macosx
	fi
}
