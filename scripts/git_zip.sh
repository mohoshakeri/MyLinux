#!/bin/bash


# Initialize Exclude Arguments
EXCLUDES=()

# Always Exclude .git Directory
EXCLUDES+=("-x" ".git/*")

# Read .gitignore If Exists And Convert To Zip Excludes
if [ -f .gitignore ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    # Skip Empty Lines And Comments
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    # Remove Trailing Slash
    pattern="${line%/}"

    # Add Exclude Pattern
    EXCLUDES+=("-x" "$pattern")
    EXCLUDES+=("-x" "$pattern/*")
  done < .gitignore
fi

# Create Zip Archive
zip -r "archive.zip" . "${EXCLUDES[@]}"
