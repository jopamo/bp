# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop doins

QA_PREBUILT="
	opt/${PN}/bin/*
	opt/${PN}/jbr/bin/*
	opt/${PN}/jbr/lib/*
	opt/${PN}/jbr/lib/jli/*
	opt/${PN}/jbr/lib/server/*
	opt/${PN}/lib/pty4j-native/linux/*/*
	opt/${PN}/plugins/android/resources/installer/*/*
	opt/${PN}/plugins/android/resources/native/*
	opt/${PN}/plugins/android/resources/perfetto/*/*
	opt/${PN}/plugins/android/resources/screen-sharing-agent/*/*
	opt/${PN}/plugins/android/resources/simpleperf/*/*
	opt/${PN}/plugins/android/resources/trace_processor_daemon/*
	opt/${PN}/plugins/android/resources/transport/*/*
	opt/${PN}/plugins/android/resources/transport/native/agent/*/*
	opt/${PN}/plugins/android-ndk/resources/lldb/android/*/*
	opt/${PN}/plugins/android-ndk/resources/lldb/bin/*
	opt/${PN}/plugins/android-ndk/resources/lldb/lib/python3.9/lib-dynload/*
	opt/${PN}/plugins/android-ndk/resources/lldb/lib64/*
	opt/${PN}/plugins/design-tools/resources/layoutlib/data/linux/lib64/*
	opt/${PN}/plugins/c-clangd/bin/clang/linux/*/*
	opt/${PN}/plugins/webp/lib/libwebp/linux/*
"

DESCRIPTION="Android development environment based on IntelliJ IDEA"
HOMEPAGE="https://developer.android.com/studio"
SRC_URI="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${PV}/${P}-linux.tar.gz"
S=${WORKDIR}/${PN}
LICENSE="Apache-2.0 android BSD BSD-2 CDDL-1.1 CPL-0.5
	EPL-1.0 GPL-2 GPL-2+ JDOM IJG LGPL-2.1 MIT
	MPL-1.1 MPL-2.0 NPL-1.1 OFL-1.1 ZLIB"
SLOT="0"
KEYWORDS="amd64"
IUSE="selinux"
RESTRICT="bindist mirror strip"

RDEPEND="${DEPEND}
	app-compression/bzip2
	fonts/fontconfig
	lib-core/expat
	lib-core/libffi
	lib-core/libxcrypt
	lib-core/ncurses5-compat
	xgui-lib/libX11
	xgui-misc/freetype
	xgui-tools/mesa
	xmedia-lib/libpng
"

src_prepare() {

	default

	rm "${S}"/plugins/android/resources/installer/{arm64-v8a,armeabi-v7a,x86}/*
	rm "${S}"/plugins/android/resources/perfetto/{arm64-v8a,armeabi-v7a,x86}/*
	rm "${S}"/plugins/android/resources/process-tracker-agent/native/{arm64-v8a,armeabi-v7a,x86}/*
	rm "${S}"/plugins/android/resources/transport/{arm64-v8a,armeabi-v7a,x86}/*
	rm "${S}"/plugins/android/resources/transport/native/agent/{arm64-v8a,armeabi-v7a,x86}/*

	cat <<-EOF >> bin/idea.properties || die
	#-----------------------------------------------------------------------
	# Disable automatic updates as these are handled through Gentoo's
	# package manager.
	#-----------------------------------------------------------------------
	ide.no.platform.update=Gentoo
	EOF
}

src_compile() {
	:;
}

src_install() {
	local dir="/opt/${PN}"
	insinto "${dir}"
	doins -r *

	fperms 755 "${dir}"/bin/{fsnotifier,format.sh,game-tools.sh,inspect.sh,ltedit.sh,profiler.sh,studio,studio.sh,studio_safe.sh}
	fperms -R 755 "${dir}"/bin/{helpers,lldb}
	fperms -R 755 "${dir}"/jbr/bin
	fperms 755 "${dir}"/jbr/lib/{jexec,jspawnhelper}
	fperms -R 755 "${dir}"/plugins/Kotlin/kotlinc/bin
	fperms -R 755 "${dir}"/plugins/android/resources/installer
	fperms -R 755 "${dir}"/plugins/android/resources/perfetto
	fperms -R 755 "${dir}"/plugins/android/resources/simpleperf
	fperms -R 755 "${dir}"/plugins/android/resources/trace_processor_daemon
	fperms -R 755 "${dir}"/plugins/android/resources/transport/{arm64-v8a,armeabi-v7a,x86,x86_64}
	fperms -R 755 "${dir}"/plugins/android-ndk/resources/lldb/{android,bin,lib,shared}
	fperms 755 "${dir}"/plugins/c-clangd-plugin/bin/clang/linux/x64/bin/clangd
	fperms -R 755 "${dir}"/plugins/terminal/shell-integrations/{,fish}

	newicon "bin/studio.png" "${PN}.png"
	make_wrapper ${PN} ${dir}/bin/studio
	make_desktop_entry ${PN} "Android Studio" ${PN} "Development;IDE" "StartupWMClass=jetbrains-studio"

	# https://developer.android.com/studio/command-line/variables
	newenvd - 99android-studio <<-EOF
		# Configuration file android-studio
		STUDIO_JDK="${dir}/jbr"
	EOF

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/" || die
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-android-studio-inotify-watches.conf" || die
}

pkg_postrm() {
	elog "Android Studio data files were not removed."
	elog "If there will be no other programs using them anymore"
	elog "(especially another flavor of Android Studio)"
	elog "remove manually following folders:"
	elog ""
	elog "		~/.android/"
	elog "		~/.config/Google/AndroidStudio*/"
	elog "		~/.local/share/Google/AndroidStudio*/"
	elog "		~/Android/"
	elog ""
	elog "Also, if there are no other programs using Gradle, remove:"
	elog ""
	elog "		~/.gradle/"
}
