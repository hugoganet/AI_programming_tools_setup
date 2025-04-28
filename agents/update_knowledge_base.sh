#!/bin/bash

# -----------------------------------------
# update_knowledge_base.sh
# -----------------------------------------
# This script rebuilds knowledge_base.md by:
# 1. Adding the update date
# 2. Adding the project structure
# 3. Adding a human-readable versions list
# -----------------------------------------

set -euo pipefail  # Safe mode: exit on error, treat unset variables as errors, fail on pipeline errors

# Get the root of the project (not AI_programming_tools_setup)
repo_root="$(git rev-parse --show-toplevel)"

# Define paths
structure_file="$repo_root/AI_programming_tools_setup/agents/project-structure.txt"
versions_file="$repo_root/AI_programming_tools_setup/agents/versions.jsonc"
knowledge_base="$repo_root/AI_programming_tools_setup/agents/knowledge_base.md"

# Clean or create knowledge_base.md
> "$knowledge_base"

# 1. Append update date
echo "## Knowledge Base" >> "$knowledge_base"
echo "" >> "$knowledge_base"
echo "_Last updated: $(date '+%Y-%m-%d %H:%M:%S')_" >> "$knowledge_base"
echo "" >> "$knowledge_base"

# 2. Append project structure
echo "## Project Structure" >> "$knowledge_base"
echo "" >> "$knowledge_base"
cat "$structure_file" >> "$knowledge_base"
echo "" >> "$knowledge_base"

# 3. Append versions information by calling Node.js script
echo "## Project Versions" >> "$knowledge_base"
echo "" >> "$knowledge_base"
node "$repo_root/AI_programming_tools_setup/agents/parse_versions_to_md.js" "$versions_file" >> "$knowledge_base"

# Done
echo "✅ knowledge_base.md updated successfully at $knowledge_base"
