# Distributed under the terms of the GNU General Public License v2

inherit desktop doins qa-policy

# The vendor-supplied IDE payload is intentionally opaque. Keep policy
# coverage on bp-owned integration files while explicitly excluding the
# bundled runtime and plugins from source-package assertions.
QA_POLICY_SKIP_PATHS="^/opt/${PN}(/|$)"

# Every file under /opt/${PN} is vendor-supplied and must remain untouched.
QA_PREBUILT="opt/${PN}/*"

DESCRIPTION="Android development environment based on IntelliJ IDEA"
HOMEPAGE="https://developer.android.com/studio"
SRC_URI="https://edgedl.me.gvt1.com/android/studio/ide-zips/${PV}/android-studio-quail3-patch1-linux.tar.gz -> ${P}-linux.tar.gz"
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
	lib-core/libxcrypt-compat
	lib-core/ncurses5-compat
	xgui-lib/libX11
	xgui-lib/freetype
	xgui-tools/mesa
	xmedia-lib/libpng
"

src_prepare() {

	default

	# rm "${S}"/plugins/android/resources/installer/{arm64-v8a,armeabi-v7a,x86}/*
	# rm "${S}"/plugins/android/resources/perfetto/{arm64-v8a,armeabi-v7a,x86}/*
	# rm "${S}"/plugins/android/resources/process-tracker-agent/native/{arm64-v8a,armeabi-v7a,x86}/*
	# rm "${S}"/plugins/android/resources/transport/{arm64-v8a,armeabi-v7a,x86}/*
	# rm "${S}"/plugins/android/resources/transport/native/agent/{arm64-v8a,armeabi-v7a,x86}/*

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

	fperms 755 "${dir}"/bin/{fsnotifier,format.sh,game-tools.sh,inspect.sh,ltedit.sh,profiler.sh,studio,studio.sh}
	fperms -R 755 "${dir}"/bin/{helpers,lldb}
	fperms -R 755 "${dir}"/jbr/bin
	fperms 755 "${dir}"/jbr/lib/{jexec,jspawnhelper}
	fperms -R 755 "${dir}"/plugins/Kotlin/kotlinc/bin
	fperms -R 755 "${dir}"/plugins/android/resources/installer
	fperms -R 755 "${dir}"/plugins/android/resources/perfetto
	fperms -R 755 "${dir}"/plugins/android/resources/simpleperf
	fperms -R 755 "${dir}"/plugins/android/resources/trace_processor_daemon
	fperms -R 755 "${dir}"/plugins/android/resources/transport/x86_64
	fperms -R 755 "${dir}"/plugins/android-ndk/resources/lldb/{android,bin,lib,shared}
	fperms 755 "${dir}"/plugins/cidr-clangd/bin/clang/linux/x64/bin/clangd
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

	qa-policy-install
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
