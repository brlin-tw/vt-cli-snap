#!/usr/bin/env bash
# Maintenance launcher of the snap.
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: Apache-2.0

set -eu

# We won't want to show the notice and the long delay when the user hits TAB,
# which the launcher will get the following arguments:
#
# $1: /bin/bash
# $2: /usr/lib/snapd/etelpmoc.sh
if ! {
    test "${#}" -ge 2 \
        && test "${2}" == /usr/lib/snapd/etelpmoc.sh
    }; then
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
    fi
fi

# Run the next program in the command chain
exec "${@}"
