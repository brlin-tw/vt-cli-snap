#!/usr/bin/env bash
# Maintenance launcher of the snap.
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: Apache-2.0

set -eu

if ! test -v SNAP_REAL_HOME; then
    printf \
        'Error: This snap requires the SNAP_REAL_HOME environment variable to be set by snapd.\n' \
        1>&2
    exit 1
fi

if ! script_name="$(basename "${0}")"; then
    printf \
        'Error: Unable to determine the basename of the script.\n' \
        1>&2
    exit 2
fi

# We won't want to show the notice and the long delay when the user hits TAB,
# which the launcher will get the following arguments:
#
# $1: /bin/bash
# $2: /usr/lib/snapd/etelpmoc.sh
if test "${#}" -ge 2 \
    && test "${2}" == /usr/lib/snapd/etelpmoc.sh; then
    exec "${@}"
fi

flag_output_separation_required=false

# Ensure that the user has read the notice
# NOTE: We can't use snapctl to read the flag because it can only be set by the snap itself when it is run as the superuser.
unofficial_notice_marker_file="${SNAP_USER_COMMON}/.snap.unofficial-notice-shown"
if test ! -f "${unofficial_notice_marker_file}"; then
    printf \
        "%s: This is NOT an official distribution of the VirusTotal CLI, refer to the snap's own issue tracker for support:\\n\\n%s\\n\\n" \
        "${script_name}" \
        https://gitlab.com/brlin/vt-cli-snap/-/issues \
        1>&2
    printf \
        '%s: NOTE: This message will only be shown once, the application will be launched in 10 seconds.\n' \
        "${script_name}" \
        1>&2
    sleep 10
    touch "${unofficial_notice_marker_file}"
    flag_output_separation_required=true
fi

# Ensure that the user know the existence of the removable-media interface
removable_media_interface_warning_disable_marker_file="${SNAP_USER_COMMON}/.snap.disable-removable-media-interface-warning"
if ! snapctl is-connected removable-media \
    && ! test -f "${removable_media_interface_warning_disable_marker_file}"; then
    printf \
        "%s: Warning: To allow the application to access files under storage mounted under the /media, /run/media, and the /mnt directories, you need to connect the snap to the \`removable-media\` snapd security confinement interface by running the following command in a text terminal:\\n\\n    sudo snap connect vt-cli:removable-media\\n\\n" \
        "${script_name}" \
        1>&2
    printf \
        '%s: NOTE: To disable this warning, you can run the following command in a text terminal:\n\n    touch "%s"\n' \
        "${script_name}" \
        "${removable_media_interface_warning_disable_marker_file}" \
        1>&2
    flag_output_separation_required=true
fi

vt_config_file_native="${SNAP_REAL_HOME}/.vt.toml"
vt_config_file_snap="${SNAP_USER_DATA}/.vt.toml"
if snapctl is-connected personal-files 2>/dev/null \
    && test -e "${vt_config_file_native}" \
    && ! test -e "${vt_config_file_snap}"; then
    printf \
        "%s: INFO: Migrating the native configuration file to the snap's data directory...\\n" \
        "${script_name}" \
        1>&2
    if ! cp -av "${vt_config_file_native}" "${vt_config_file_snap}"; then
        printf \
            "%s: Error: Unable to migrate the native configuration file to the snap's data directory.\\n" \
            "${script_name}" \
            1>&2
        exit 2
    fi
    flag_output_separation_required=true
fi

if "${flag_output_separation_required}"; then
    printf '\n--------------------------------\n\n' 1>&2
fi

# Run the next program in the command chain
exec "${@}"
