#!/bin/bash

# Number of bars
bars=20

# Start cava in raw output mode
cava_out=$(cava -p ~/.config/cava/config | head -n $bars)

# Convert the values into nice Unicode bars
bars_output=""
for level in $cava_out; do
  # Normalize level to 0-8 (you can tweak this based on your volume)
  level=$((level / 100))
  [ "$level" -gt 8 ] && level=8
  # Unicode block elements
  blocks=(" " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")
  bars_output+="${blocks[$level]}"
done

echo "{\"text\":\"$bars_output\",\"tooltip\":\"cava visualizer\"}"
