#!/usr/bin/env zsh

# Create a temporary directory for fetching files
TEMP_DIR=$(mktemp -d)

# Extract URLs and filenames from your configuration
declare -A urls
urls["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting/archive/refs/tags/0.6.0.tar.gz"
urls["formarks"]="https://github.com/wfxr/formarks/archive/8abce138218a8e6acd3c8ad2dd52550198625944.tar.gz"
urls["zsh-abbrev-alias"]="https://github.com/momo-lab/zsh-abbrev-alias/archive/637f0b2dda6d392bf710190ee472a48a20766c07.tar.gz"
urls["zsh-autopair"]="https://github.com/hlissner/zsh-autopair/archive/34a8bca0c18fcf3ab1561caef9790abffc1d3d49.tar.gz"
urls["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions/archive/v0.7.0.tar.gz"

# Function to fetch and compute hash
fetch_and_hash() {
  local name=$1
  local url=$2

  echo "Fetching $name from $url..."
  curl -L "$url" | sha256sum | awk '{ print $1 }'
}

# Fetch files and print hashes
for name in ${(k)urls}; do
  hash=$(fetch_and_hash "$name" "${urls[$name]}")
  echo "$name: sha256-$hash"
done

# Clean up
rm -rf "$TEMP_DIR"
