#!/usr/bin/env bash
# Script to customize the prime step of the vt-cli Snapcraft part.
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: Apache-2.0

set -eu

if ! craftctl default; then
    printf \
        'Error: Unable to run the default logic of the prime step.\n' \
        1>&2
    exit 2
fi

# WORKAROUND: Make a symbolic link to have the command `vt-cli` available
# because there's no way to differentiate the two commands `vt` and `vt-cli`
# without doing so.
# Is there any easy way to know which app command is choosen by the snap runtime? - snapd - snapcraft.io
# https://forum.snapcraft.io/t/is-there-any-easy-way-to-know-which-app-command-is-choosen-by-the-snap-runtime/48451
ln_opts=(
    --symbolic
    --relative
    --force
    --verbose
)
if ! ln "${ln_opts[@]}" "${CRAFT_PRIME}/bin/vt" "${CRAFT_PRIME}/bin/vt-cli"; then
    printf \
        'Error: Unable to create the workaround symbolic link for the app command vt-cli.\n' \
        1>&2
    exit 2
fi
