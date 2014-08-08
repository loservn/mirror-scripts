#!/bin/bash

source env.sh || { echo >&2 "env.sh not found"; exit 127; }

_ftmp="$D_VAR/report.tmp.log"

cat \
| grep -E '\.[gx]z$' \
| grep -v -- '->' \
| grep -v '^os/' \
| grep -v ' os/' \
> $_ftmp

_n_update="$(grep -v "deleting " $_ftmp | wc -l)"
_n_delete="$(grep "deleting " $_ftmp | wc -l)"
_n_64="$(find $D_MIRROR/pool/ -iname "*.xz" | grep x86_64 |wc -l)"
_n_32="$(find $D_MIRROR/pool/ -iname "*.xz" | grep i686 |wc -l)"

echo "{
\"number_of_packages_x86_64\": $_n_64,
\"number_of_packages_i686\": $_n_32,
\"number_of_updated_packages\": $_n_update,
\"number_of_deleted_packages\": $_n_delete,
\"report_time\": \"$(__now__)\"
}"
