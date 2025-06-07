# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A tool for organizing and renaming video files."
HOMEPAGE="https://www.filebot.net/"
SRC_URI="https://1g4.org/files/FileBot_${PV}-portable.tar.xz"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="preserve-libs strip"
QA_PREBUILT="*"

RDEPEND="bin/openjdk8"

S=${WORKDIR}

src_install() {
	HERE="${ED}"/opt/filebot

	mkdir -p "${HERE}" || die
	cp -rp "${S}"/* "${HERE}"/ || die
	find "${ED}" -type d -empty -delete || die

	#Cleanup
	rm -r "${HERE}"/lib/{aarch64,armv7l,i686} || die
	rm "${HERE}"/lib/x86_64/libmediainfo.so || die

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=opt/filebot" >> ${T}/10filebot
	doins "${T}"/10filebot || die

	# Create shortcut
	dodir /usr/bin/
	cat <<-EOF >"${D}"/usr/bin/filebot
	#!/bin/sh
	exec /opt/openjdk8/bin/java -jar /opt/filebot/FileBot.jar "\$@"
	EOF
	fperms 0755 /usr/bin/filebot
}
