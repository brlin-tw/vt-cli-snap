#!/usr/bin/env bash
# Script to customize the build step of the vt-cli Snapcraft part.
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: Apache-2.0

set -eux

if ! craftctl default; then
    printf \
        'Error: Unable to run the default logic of the build step.\n' \
        1>&2
    exit 2
fi

if ! mkdir -p "${CRAFT_PART_INSTALL}/etc/bash_completion.d"; then
    printf \
        'Error: Unable to create the bash completion directory.\n' \
        1>&2
    exit 2
fi

if ! "${CRAFT_PART_INSTALL}/bin/vt" completion bash \
    >"${CRAFT_PART_INSTALL}/etc/bash_completion.d/vt"; then
    printf \
        'Error: Unable to generate the bash completion file.\n' \
        1>&2
    exit 2
fi

sed_opts=(
    --in-place
    --expression='s/__start_vt vt/__start_vt vt-cli vt-cli.vt/'
)
if ! sed "${sed_opts[@]}" "${CRAFT_PART_INSTALL}/etc/bash_completion.d/vt"; then
    printf \
        'Error: Unable to patch the bash completion file.\n' \
        1>&2
    exit 2
fi
