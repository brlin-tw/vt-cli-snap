#!/usr/bin/env bash
# Script to customize the pull step of the vt-cli Snapcraft part.
#
# Copyright 2025 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: Apache-2.0

set -eu

if ! craftctl default; then
    printf \
        'Error: Unable to run the default logic of the pull step.\n' \
        1>&2
    exit 2
fi

if ! part_version="$(
    git -C "${CRAFT_PART_SRC}" describe \
        --always \
        --dirty \
        --match='*.*.*' \
        --tags
    )"; then
    printf \
        'Error: Unable to describe the version of the main part.\n' \
        1>&2
    exit 2
fi
printf \
    'Info: The version of the main part is determined as %s.\n' \
    "${part_version}" \
    1>&2

if ! packaging_version="$(
    git -C "${CRAFT_PROJECT_DIR}" describe \
        --always \
        --dirty \
        --abbrev=3
    )"; then
    printf \
        'Error: Unable to describe the packaging version.\n' \
        1>&2
    exit 2
fi
printf \
    'Info: The packaging version is determined as %s.\n' \
    "${packaging_version}" \
    1>&2

snap_version="${part_version}+s${packaging_version}"
if ! craftctl set version="${snap_version}"; then
    printf \
        'Error: Unable to set the version of the snap.\n' \
        1>&2
    exit 2
fi
printf \
    'Info: The version of the snap is set to %s.\n' \
    "${snap_version}" \
    1>&2
