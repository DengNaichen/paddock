#!/usr/bin/env bash
# End-to-end check inside herdr: temp repo, one impl + one review with the given kind (default pi).
set -euo pipefail
kind=${1:-pi}
d=$(mktemp -d); export WT_ROOT=$d/wts
git init -q -b main "$d/repo" && cd "$d/repo"
echo x > README.md && git add . && git -c user.name=t -c user.email=t@t commit -qm init
wt spawn smoke impl "$kind" "Create hello.txt containing hi and git commit it."
wt spawn smoke review "$kind" "Read-only review of git show HEAD; write LGTM if fine."
git -C "$WT_ROOT/repo/smoke" log --oneline | grep -q hello || git -C "$WT_ROOT/repo/smoke" log --oneline -2
echo "smoke ok (cleanup: wt rm smoke --yes; rm -rf $d)"
