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

# We won't want to show the notice and the long delay when the user hits TAB,
# which the launcher will get the following arguments:
#
# $1: /bin/bash
# $2: /usr/lib/snapd/etelpmoc.sh
if test "${#}" -ge 2 \
    && test "${2}" == /usr/lib/snapd/etelpmoc.sh; then
    exec "${@}"
fi

# Ensure that the user has read the notice
# NOTE: We can't use snapctl to read the flag because it can only be set by the snap itself when it is run as the superuser.
marker_file="${SNAP_USER_COMMON}/.snap.unofficial-notice-shown"
if test ! -f "${marker_file}"; then
    printf \
        "This is NOT an official distribution of the VirusTotal CLI, refer to the snap's own issue tracker for support:\\n\\n%s\\n\\n" \
        https://gitlab.com/brlin/vt-cli-snap/-/issues \
        1>&2
    printf \
        'NOTE: This message will only be shown once, the application will be launched in 10 seconds.\n' \
        1>&2
    sleep 10
    touch "${marker_file}"
    printf '\n--------------------------------\n\n' 1>&2
fi

vt_config_file_native="${SNAP_REAL_HOME}/.vt.toml"
vt_config_file_snap="${SNAP_USER_DATA}/.vt.toml"
if test -e "${vt_config_file_native}" \
    && ! test -e "${vt_config_file_snap}"; then
    printf \
        "INFO: Migrating the native configuration file to the snap's data directory...\\n" \
        1>&2
    if ! cp -a "${vt_config_file_native}" "${vt_config_file_snap}"; then
        printf \
            "Error: Unable to migrate the native configuration file to the snap's data directory.\\n" \
            1>&2
        exit 2
    fi
fi

# Run the next program in the command chain
exec "${@}"
