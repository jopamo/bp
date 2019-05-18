# Distributed under the terms of the GNU General Public License v2

# @ECLASS: gnome2-utils.eclass
# @MAINTAINER:
# gnome@gentoo.org
# @SUPPORTED_EAPIS: 0 1 2 3 4 5 6 7
# @BLURB: Auxiliary functions commonly used by Gnome packages.
# @DESCRIPTION:
# This eclass provides a set of auxiliary functions needed by most Gnome
# packages. It may be used by non-Gnome packages as needed for handling various
# Gnome stack related functions such as:
#  * GSettings schemas management
#  * GConf schemas management
#  * scrollkeeper (old Gnome help system) management

[[ ${EAPI:-0} == [0123456] ]] && inherit eutils

case "${EAPI:-0}" in
	0|1|2|3|4|5|6|7) ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

# @ECLASS-VARIABLE: GCONFTOOL_BIN
# @INTERNAL
# @DESCRIPTION:
# Path to gconftool-2
: ${GCONFTOOL_BIN:="/usr/bin/gconftool-2"}

# @ECLASS-VARIABLE: SCROLLKEEPER_DIR
# @INTERNAL
# @DESCRIPTION:
# Directory where scrollkeeper-update should do its work
: ${SCROLLKEEPER_DIR:="/var/lib/scrollkeeper"}

# @ECLASS-VARIABLE: SCROLLKEEPER_UPDATE_BIN
# @INTERNAL
# @DESCRIPTION:
# Path to scrollkeeper-update
: ${SCROLLKEEPER_UPDATE_BIN:="/usr/bin/scrollkeeper-update"}

# @ECLASS-VARIABLE: GLIB_COMPILE_SCHEMAS
# @INTERNAL
# @DESCRIPTION:
# Path to glib-compile-schemas
: ${GLIB_COMPILE_SCHEMAS:="/usr/bin/glib-compile-schemas"}

# @ECLASS-VARIABLE: GNOME2_ECLASS_SCHEMAS
# @INTERNAL
# @DEFAULT_UNSET
# @DESCRIPTION:
# List of GConf schemas provided by the package

# @ECLASS-VARIABLE: GNOME2_ECLASS_ICONS
# @INTERNAL
# @DEFAULT_UNSET
# @DESCRIPTION:
# List of icons provided by the package

# @ECLASS-VARIABLE: GNOME2_ECLASS_SCROLLS
# @INTERNAL
# @DEFAULT_UNSET
# @DESCRIPTION:
# List of scrolls (documentation files) provided by the package

# @ECLASS-VARIABLE: GNOME2_ECLASS_GLIB_SCHEMAS
# @INTERNAL
# @DEFAULT_UNSET
# @DESCRIPTION:
# List of GSettings schemas provided by the package

# @ECLASS-VARIABLE: GNOME2_ECLASS_GDK_PIXBUF_LOADERS
# @INTERNAL
# @DEFAULT_UNSET
# @DESCRIPTION:
# List of gdk-pixbuf loaders provided by the package


# @FUNCTION: gnome2_environment_reset
# @DESCRIPTION:
# Reset various variables inherited from root's evironment to a reasonable
# default for ebuilds to help avoid access violations and test failures.
gnome2_environment_reset() {
	xdg_environment_reset

	# Respected by >=glib-2.30.1-r1
	export G_HOME="${T}"

	# GST_REGISTRY is to work around gst utilities trying to read/write /root
	export GST_REGISTRY="${T}/registry.xml"

	# Ensure we don't rely on dconf/gconf while building, bug #511946
	export GSETTINGS_BACKEND="memory"

	if has ${EAPI:-0} 6 7; then
		# Try to cover the packages honoring this variable, bug #508124
		export GST_INSPECT="$(type -P true)"

		# Stop relying on random DISPLAY variable values, bug #534312
		unset DISPLAY
	fi
}

case ${EAPI:-0} in
0|1|2|3|4|5|6)

# @FUNCTION: gnome2_icon_savelist
# @DESCRIPTION:
# Find the icons that are about to be installed and save their location
# in the GNOME2_ECLASS_ICONS environment variable. This is only
# necessary for eclass implementations that call
# gnome2_icon_cache_update conditionally.
# This function should be called from pkg_preinst.
gnome2_icon_savelist() {
	has ${EAPI:-0} 0 1 2 && ! use prefix && ED="${D}"
	pushd "${ED}" > /dev/null || die
	export GNOME2_ECLASS_ICONS=$(find 'usr/share/icons' -maxdepth 1 -mindepth 1 -type d 2> /dev/null)
	popd > /dev/null || die
}

;;
esac
