# Docker Handbrake CLI
A Docker container to encode with x265 using high-quality presets in Handbrake.

NOTE: These encodes will be slow but will result in high-quality output files, relative to their size.

## Usage
`docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli <input_file> [preset_name] [crf_value]`

### Presets
| Preset name       | Default CRF  |
|:------------------|:-------------|
| `1080p`           | 20           |
| `1080p-animation` | 16           |
| `4k`              | 16           |
| `4k-animation`    | 12           |

If no preset is given, the 1080p preset will be used by default.

## Examples
### Default preset
`docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli video.mkv`

### 1080p preset with custom CRF
`docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli video.mkv 1080p 22`

### 4K Animation preset with default CRF
`docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli video.mkv 4k-animation`