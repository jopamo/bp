# Distributed under the terms of the GNU General Public License v2

case "${EAPI:-0}" in
	0|1|2|3|4|5|6|7) ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

EXPORT_FUNCTIONS pkg_postinst pkg_postrm

# @ECLASS-VARIABLE: DESKTOP_DATABASE_DIR
# @INTERNAL
# @DESCRIPTION:
# Directory where .desktop files database is stored
: ${DESKTOP_DATABASE_DIR="/usr/share/applications"}

# @ECLASS-VARIABLE: MIMEINFO_DATABASE_DIR
# @INTERNAL
# @DESCRIPTION:
# Directory where .desktop files database is stored
: ${MIMEINFO_DATABASE_DIR:="/usr/share/mime"}

# @FUNCTION: gnome2_environment_reset
# @DESCRIPTION:
# Reset various variables inherited from root's evironment to a reasonable
# default for ebuilds to help avoid access violations and test failures.
gnome2_environment_reset() {
	[[ ${EAPI} == [7] ]] && xdg_environment_reset

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

# @FUNCTION: xdg_desktop_database_update
# @DESCRIPTION:
# Updates the .desktop files database.
# Generates a list of mimetypes linked to applications that can handle them
xdg_desktop_database_update() {
	if [[ ${EBUILD_PHASE} != post* ]] ; then
		die "xdg_desktop_database_update must be used in pkg_post* phases."
	fi

	if ! type update-desktop-database &>/dev/null; then
		debug-print "update-desktop-database is not found"
		return
	fi

	ebegin "Updating .desktop files database"
	update-desktop-database -q "${EROOT}"/${DESKTOP_DATABASE_DIR}
	eend $?
}

# @FUNCTION: xdg_icon_cache_update
# @DESCRIPTION:
# Updates icon theme cache files under /usr/share/icons.
# This function should be called from pkg_postinst and pkg_postrm.
xdg_icon_cache_update() {
	if [[ ${EBUILD_PHASE} != post* ]] ; then
		die "xdg_icon_cache_update must be used in pkg_post* phases."
	fi

	if ! type gtk-update-icon-cache &>/dev/null; then
		debug-print "gtk-update-icon-cache is not found"
		return
	fi

	ebegin "Updating icons cache"
	local retval=0
	local fails=( )
	for dir in "${EROOT}"/usr/share/icons/*
	do
		if [[ -f "${dir}/index.theme" ]] ; then
			local rv=0
			gtk-update-icon-cache -qf "${dir}"
			rv=$?
			if [[ ! $rv -eq 0 ]] ; then
				debug-print "Updating cache failed on ${dir}"
				# Add to the list of failures
				fails+=( "${dir}" )
				retval=2
			fi
		elif [[ $(ls "${dir}") = "icon-theme.cache" ]]; then
			# Clear stale cache files after theme uninstallation
			rm "${dir}/icon-theme.cache"
		fi
		if [[ -z $(ls "${dir}") ]]; then
			# Clear empty theme directories after theme uninstallation
			rmdir "${dir}"
		fi
	done
	eend ${retval}
	for f in "${fails[@]}" ; do
		eerror "Failed to update cache with icon $f"
	done
}

# @FUNCTION: xdg_mimeinfo_database_update
# @DESCRIPTION:
# Update the mime database.
# Creates a general list of mime types from several sources
xdg_mimeinfo_database_update() {
	if [[ ${EBUILD_PHASE} != post* ]] ; then
		die "xdg_mimeinfo_database_update must be used in pkg_post* phases."
	fi

	if ! type update-mime-database &>/dev/null; then
		debug-print "update-mime-database is not found"
		return
	fi

	update-mime-database "${EROOT}"/${MIMEINFO_DATABASE_DIR}
	eend $?
}

# @FUNCTION: _iconins
# @INTERNAL
# @DESCRIPTION:
# function for use in doicon and newicon
_iconins() {
	(
	# wrap the env here so that the 'insinto' call
	# doesn't corrupt the env of the caller
	insopts -m 0644
	local funcname=$1; shift
	local size dir
	local context=apps
	local theme=hicolor

	while [[ $# -gt 0 ]] ; do
		case $1 in
		-s|--size)
			if [[ ${2%%x*}x${2%%x*} == "$2" ]] ; then
				size=${2%%x*}
			else
				size=${2}
			fi
			case ${size} in
			16|22|24|32|36|48|64|72|96|128|192|256|512)
				size=${size}x${size};;
			scalable)
				;;
			*)
				eerror "${size} is an unsupported icon size!"
				exit 1;;
			esac
			shift 2;;
		-t|--theme)
			theme=${2}
			shift 2;;
		-c|--context)
			context=${2}
			shift 2;;
		*)
			if [[ -z ${size} ]] ; then
				insinto /usr/share/pixmaps
			else
				insinto /usr/share/icons/${theme}/${size}/${context}
			fi

			if [[ ${funcname} == doicon ]] ; then
				if [[ -f $1 ]] ; then
					doins "${1}"
				elif [[ -d $1 ]] ; then
					shopt -s nullglob
					doins "${1}"/*.{png,svg}
					shopt -u nullglob
				else
					eerror "${1} is not a valid file/directory!"
					exit 1
				fi
			else
				break
			fi
			shift 1;;
		esac
	done
	if [[ ${funcname} == newicon ]] ; then
		newins "$@"
	fi
	) || die
}

# @FUNCTION: doicon
# @USAGE: [options] <icons>
# @DESCRIPTION:
# Install icon into the icon directory /usr/share/icons or into
# /usr/share/pixmaps if "--size" is not set.
# This is useful in conjunction with creating desktop/menu files.
#
# @CODE
#  options:
#  -s, --size
#    !!! must specify to install into /usr/share/icons/... !!!
#    size of the icon, like 48 or 48x48
#    supported icon sizes are:
#    16 22 24 32 36 48 64 72 96 128 192 256 512 scalable
#  -c, --context
#    defaults to "apps"
#  -t, --theme
#    defaults to "hicolor"
#
# icons: list of icons
#
# example 1: doicon foobar.png fuqbar.svg suckbar.png
# results in: insinto /usr/share/pixmaps
#             doins foobar.png fuqbar.svg suckbar.png
#
# example 2: doicon -s 48 foobar.png fuqbar.png blobbar.png
# results in: insinto /usr/share/icons/hicolor/48x48/apps
#             doins foobar.png fuqbar.png blobbar.png
# @CODE
doicon() {
	_iconins ${FUNCNAME} "$@"
}

# @FUNCTION: newicon
# @USAGE: [options] <icon> <newname>
# @DESCRIPTION:
# Like doicon, install the specified icon as newname.
#
# @CODE
# example 1: newicon foobar.png NEWNAME.png
# results in: insinto /usr/share/pixmaps
#             newins foobar.png NEWNAME.png
#
# example 2: newicon -s 48 foobar.png NEWNAME.png
# results in: insinto /usr/share/icons/hicolor/48x48/apps
#             newins foobar.png NEWNAME.png
# @CODE
newicon() {
	_iconins ${FUNCNAME} "$@"
}

xdg-utils_pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

xdg-utils_pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
