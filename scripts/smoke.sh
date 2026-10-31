#!/usr/bin/env bash
# End-to-end check inside herdr, in a temp repo: one writer type, then one reviewer type.
# Usage: smoke.sh [writer-type] [reviewer-type]   (default: backend review; see roles.json)
# Run it from a repo your agents already trust, or confirm their folder-trust prompts once.
set -euo pipefail
writer=${1:-backend}; reviewer=${2:-review}
d=$(mktemp -d); export WT_ROOT=$d/wts
git init -q -b main "$d/repo" && cd "$d/repo"
echo x > README.md && git add . && git -c user.name=t -c user.email=t@t commit -qm init
wt spawn smoke "$writer" "Create hello.txt containing hi and git commit it."
wt spawn smoke "$reviewer" "Read-only review of git show HEAD; write LGTM if fine."
git -C "$WT_ROOT/repo/smoke" log --oneline -2
echo "smoke ok (cleanup: wt rm smoke --yes; rm -rf $d)"
