# Docker HandBrake CLI
A Docker container for HandBrake CLI.

Built for AMD64 and ARM64.

## Usage
``` bash
docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli:latest -i <input_file> -o <output_file>
```

## Examples
### Simple command
``` bash
docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli:latest -i /data/input.mkv -o /data/output.mkv
```

### Regular command (example from HandBrake's documentation)
``` bash
docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli:latest -i /data/input.mkv -o /data/output.mkv -e x264 -q 20 -B 160
```

### Complex command (example from HandBrake's documentation)
``` bash
docker run --rm -v "$(pwd)":/data davidmatthews/handbrake-cli:latest -i /data/input.mkv -o /data/output.mkv -m -E copy –audio-copy-mask ac3,dts,dtshd –audio-fallback ffac3 -e x264 -q 20 -x level=4.1:ref=4:b-adapt=2:direct=auto:me=umh:subq=8:rc-lookahead=50:psy-rd=1.0,0.15:deblock=-1,-1:vbv-bufsize=30000:vbv-maxrate=40000:slices=4
```

## Links
[GitHub](https://github.com/davidmatthews/docker-handbrake-cli)

[Docker Hub](https://hub.docker.com/r/davidmatthews/handbrake-cli)
