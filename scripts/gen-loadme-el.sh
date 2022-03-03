#!/usr/bin/env bash

result=$(nix-build -A env --no-out-link ./project.nix)

agda="$result/bin/agda"
agda_mode="$($result/bin/agda-mode locate)"

cat > loadme.el <<EOF
(setq agda2-program-name "$agda")
(load-file "$agda_mode")
EOF

echo "wrote to loadme.el"
