#!/usr/bin/env bash
# Configuration
WALLPAPER_DIR="$HOME/Documents/wallpapers"  # Change this to your wallpaper directory
CACHE_DIR="$HOME/.cache/wallpaper-selector"
THUMBNAIL_WIDTH="250"  # Size of thumbnails in pixels (16:9)
THUMBNAIL_HEIGHT="141"
# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Function to generate thumbnail
generate_thumbnail() {
    local input="$1"
    local output="$2"
    magick "$input" -thumbnail "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}^" -gravity center -extent "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" "$output"
}

# Create shuffle icon thumbnail on the fly
SHUFFLE_ICON="$CACHE_DIR/shuffle_thumbnail.png"
# Create a properly sized shuffle icon thumbnail
# magick -size "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" xc:#1e1e2e \
#     "$HOME/Repos/wallpaper-selector/assets/shuffle.png" -resize "120x120" -gravity center -composite \
#     "$SHUFFLE_ICON"
magick -size "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" xc:#1e1e2e \
    \( "$HOME/Documents/assets/shuffle.png" -resize "80x80" \) \
    -gravity center -composite "$SHUFFLE_ICON"

# Generate thumbnails and create menu items
generate_menu() {
    # Add random/shuffle option with a name that sorts first (using ! prefix)
    echo -en "img:$SHUFFLE_ICON\x00info:!Random Wallpaper\x1fRANDOM\n"
    
    # Then add all wallpapers
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        # Skip if no matches found
        [[ -f "$img" ]] || continue
        
        # Generate thumbnail filename
        thumbnail="$CACHE_DIR/$(basename "${img%.*}").png"
        
        # Generate thumbnail if it doesn't exist or is older than source
        if [[ ! -f "$thumbnail" ]] || [[ "$img" -nt "$thumbnail" ]]; then
            generate_thumbnail "$img" "$thumbnail"
        fi
        
        # Output menu item (filename and path)
        echo -en "img:$thumbnail\x00info:$(basename "$img")\x1f$img\n"
    done
}

# Use wofi to display grid of wallpapers - IMPORTANT: added --sort-order=default
selected=$(generate_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image-size=${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
    --columns 3 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --conf ~/.config/wofi/wallpaper.conf \
    --style ~/.config/wofi/wallpaper.css \
  )

# Set wallpaper if one was selected
if [ -n "$selected" ]; then
    
    # This logic handles the two different outputs from the generate_menu function.
    if [[ "$selected" == *"RANDOM"* ]]; then
        # If RANDOM was chosen, pick a random wallpaper from the directory
        original_path=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
    else
        # CORRECTED LOGIC:
        # The 'selected' variable is the full path to the thumbnail in the cache.
        # 1. Get just the filename from the cache path (e.g., "changli.png")
        thumbnail_filename=$(basename "$selected")
        
        # 2. Strip the extension to get the base name (e.g., "changli")
        base_filename="${thumbnail_filename%.*}"

        # 3. Find the original file in your wallpapers directory that matches the base name
        original_path=$(find "$WALLPAPER_DIR" -type f -name "${base_filename}.*" | head -n 1)
    fi

    # Ensure a valid wallpaper was found before proceeding
    if [ -n "$original_path" ] && [ -f "$original_path" ]; then
        
        # --- Run swww and pywal ---
        swww query || swww init
        swww img "$original_path" --transition-type center --transition-fps 60
        wal -i "$original_path" -n -q

        notify-send "Wallpaper Updated" "Theme set to $(basename "$original_path")" -i "$original_path"
    else
        notify-send "Wallpaper Script Error" "Could not find original file for: '$selected'"
    fi
fi