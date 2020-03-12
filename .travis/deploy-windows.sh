#!/bin/sh -ex

COMPATDB='https://rpcs3.net/compatibility?api=v1&export'

# Remove unecessary files
rm -f ./bin/rpcs3.exp ./bin/rpcs3.lib ./bin/rpcs3.pdb

# Prepare compatibility database for packaging
curl -sL "$COMPATDB" | iconv -t UTF-8 > ./bin/GuiConfigs/compat_database.dat

# Package artifacts
7z a -m0=LZMA2 -mx9 "$BUILD" ./bin/*

# Generate sha256 hashes
sha256sum "$BUILD" | awk '{ print $1 }' > "$BUILD.sha256"

# Move files to publishing directory
mv -- "$BUILD" "$ARTIFACT_DIR"
mv -- "$BUILD.sha256" "$ARTIFACT_DIR"
