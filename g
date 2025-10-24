#!/usr/bin/env bash
# update broken/misleading DESCRIPTION fields in ebuilds
# this assumes DESCRIPTION is on a single line like: DESCRIPTION="..."

set -euo pipefail

replace_desc() {
	local file="$1"
	local newdesc="$2"

	if [[ ! -f "$file" ]]; then
		echo "warn: $file not found, skipping" >&2
		return
	fi

	sed -i -E 's|^DESCRIPTION=.*$|DESCRIPTION="'"$newdesc"'"|' "$file"
	echo "ok: $file"
}

# xcb-util-m4
replace_desc xgui-lib/xcb-util-m4/xcb-util-m4-20220701.ebuild \
"Autoconf/automake macros shared by xcb-util libraries"

# libxcvt
replace_desc xgui-lib/libxcvt/libxcvt-20250329.ebuild \
"VESA Coordinated Video Timings (CVT) modeline generation library"

# gtk2 / gtk3 / gtk4
replace_desc xgui-lib/gtk2/gtk2-2.24.20201220.ebuild \
"Multi-platform toolkit for creating graphical user interfaces"
replace_desc xgui-lib/gtk3/gtk3-3.24.20250807.ebuild \
"Multi-platform toolkit for creating graphical user interfaces"
replace_desc xgui-lib/gtk4/gtk4-4.18.20250911.ebuild \
"Multi-platform toolkit for creating graphical user interfaces"

# glibmm
replace_desc xgui-lib/glibmm/glibmm-9999.ebuild \
"C++ bindings for GLib (low-level core library used by GTK and GNOME)"

# qtdeclarative (Qt 6 build must not say Qt5)
replace_desc xgui-lib/qtdeclarative/qtdeclarative-6.9.9999.ebuild \
"Qt QML and Qt Quick modules for the Qt 6 framework"

# lxqt-session
replace_desc xgui-lib/lxqt-session/lxqt-session-20251016.ebuild \
"LXQt session manager (startup, logout, autostart handling)"

# lxqt-config
replace_desc xgui-lib/lxqt-config/lxqt-config-20251015.ebuild \
"LXQt configuration center and tools for editing desktop settings"

# lxqt-menu-data
replace_desc xgui-lib/lxqt-menu-data/lxqt-menu-data-20250907.ebuild \
"Menu metadata and categories used by LXQt application menus"

# qtsvg (Qt 6 variant)
replace_desc xgui-lib/qtsvg/qtsvg-6.9.9999.ebuild \
"SVG image format support module for Qt 6"

# qtmultimedia (Qt 6 variant)
replace_desc xgui-lib/qtmultimedia/qtmultimedia-6.9.9999.ebuild \
"Qt 6 multimedia framework for audio, video, radio, and camera"

# libxkbcommon
replace_desc xgui-lib/libxkbcommon/libxkbcommon-20251017.ebuild \
"Keymap handling library for Wayland and X11 (xkbcommon)"

# libdrm
replace_desc xgui-lib/libdrm/libdrm-20250811.ebuild \
"Userspace interface to the Linux kernel DRM subsystem"

# llama-cpp
replace_desc app-dev/llama-cpp/llama-cpp-20251018.ebuild \
"High-performance inference of large language models (llama.cpp)"

# cmake
replace_desc app-dev/cmake/cmake-3.31.9-r9.ebuild \
"Cross-platform build system generator"

# debootstrap
replace_desc app-dev/debootstrap/debootstrap-9999.ebuild \
"Tool to create a minimal Debian/Ubuntu root filesystem from scratch"

# autoconf
replace_desc app-build/autoconf/autoconf-2.72.ebuild \
"Generates configure scripts to automatically configure source code"

# rust-bin (both versions)
replace_desc bin/rust-bin/rust-bin-1.88.0.ebuild \
"Prebuilt Rust compiler and toolchain (systems programming language)"
replace_desc bin/rust-bin/rust-bin-1.90.0.ebuild \
"Prebuilt Rust compiler and toolchain (systems programming language)"

# clion
replace_desc bin/clion/clion-2024.1.1.ebuild \
"JetBrains CLion: cross-platform C and C++ IDE"

# kernel-bin
replace_desc app-kernel/kernel-bin/kernel-bin-6.15.20250820.ebuild \
"Prebuilt Linux kernel and supporting files"

# intel-ucode
replace_desc app-kernel/intel-ucode/intel-ucode-20250811.ebuild \
"Intel CPU microcode update blobs for early-boot loading"

# libgit2
replace_desc lib-net/libgit2/libgit2-20250811.ebuild \
"Portable, pure-library implementation of core Git functionality"

# gnutls
replace_desc lib-net/gnutls/gnutls-3.8.10.ebuild \
"GNU TLS library providing SSL/TLS and cryptography (TLS 1.3 etc.)"

# slang
replace_desc lib-dev/slang/slang-2.3.3.ebuild \
"S-Lang interpreter and terminal UI library (embedded scripting, curses-like widgets)"

# libuv
replace_desc lib-dev/libuv/libuv-20251015.ebuild \
"Cross-platform asynchronous I/O and event loop library (libuv)"

# libatomic_ops
replace_desc lib-core/libatomic_ops/libatomic_ops-20250917.ebuild \
"Portable atomic operations library used by garbage collectors and concurrent code"

# readline
replace_desc lib-core/readline/readline-8.3.20250711.ebuild \
"GNU readline: interactive line editing and history capabilities"

# adwaita-icon-theme
replace_desc xgui-icontheme/adwaita-icon-theme/adwaita-icon-theme-48.20250624.ebuild \
"Adwaita icon theme (GNOME default system icon set)"

# libclc
replace_desc xgui-tools/libclc/libclc-19.20250114.ebuild \
"Implementation of OpenCL C built-in libraries for GPU/OpenCL compilers"

# xhost
replace_desc xgui-tools/xhost/xhost-20250415.ebuild \
"X server access control utility"

# qttools (all variants currently claiming to just be docs or saying Qt5)
replace_desc xgui-lib/qttools/qttools-6.9.9999.ebuild \
"Qt Tools collection (Assistant, Designer, Linguist, etc.)"
replace_desc xgui-lib/qttools/qttools-6.8.9999.ebuild \
"Qt Tools collection (Assistant, Designer, Linguist, etc.)"
replace_desc xgui-lib/qttools/qttools-5.15.9999.ebuild \
"Qt Tools collection (Assistant, Designer, Linguist, etc.)"

# vte (drop trailing period and tighten wording)
replace_desc xgui-lib/vte/vte-20251011.ebuild \
"Virtual terminal emulator widget for GTK applications (VTE)"

# jitterentropy
replace_desc lib-net/jitterentropy/jitterentropy-20250630.ebuild \
"CPU execution-timing jitter based entropy generator (jitterentropy)"

echo "done"

