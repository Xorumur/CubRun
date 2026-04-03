# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**cub3D** is a 42 school raycaster project inspired by Wolfenstein 3D. The binary is named `cubrun`. It takes a `.cub` scene file as its only argument and renders a first-person 3D maze view using the ray-casting technique via miniLibX.

## Build Commands

```sh
make          # build cubrun (also builds libft and ft_printf)
make re       # full rebuild
make clean    # remove object files
make fclean   # remove objects + binary
./cubrun map.cub
```

> **Note:** `lib/minilibx-linux/` is currently empty. Populate it before the project will link. The Makefile also references `lib/ft_printf` (present) and `lib/libft` (present).

## Docker Workflow (required on Mac M1)

minilibx-linux requires a Linux x86_64 environment. Use Docker + XQuartz:

**One-time setup:**
1. Install [XQuartz](https://www.xquartz.org/)
2. Open XQuartz > Preferences > Security > check "Allow connections from network clients"
3. Restart XQuartz

**Build the image:**
```sh
make docker-build
```

**Compile and run with a map:**
```sh
make docker-run MAP=maps/my_map.cub   # default MAP=map.cub
```

**Interactive shell inside the container:**
```sh
make docker-shell
```

The container mounts the project directory at `/app`, so edits on the host are immediately visible inside. The `--platform linux/amd64` flag forces x86_64 emulation via Rosetta 2.

## Architecture

The project is at scaffold stage. The current structure:

- `src/` — all `.c` source files (wildcarded by Makefile)
- `include/cubrun.h` — main header; currently includes libft and ft_printf
- `lib/libft/` — custom libc functions
- `lib/ft_printf/` — custom printf
- `lib/minilibx-linux/` — miniLibX graphics library (must be populated)
- `sprites/` — XPM sprite files (`bob.xpm`, `carlo.xpm`, `krab.xpm`, `patoche.xpm`)
- `obj/` — compiled object files (generated)

## Mandatory Features to Implement

1. **Parser** — read `.cub` file: `NO/SO/WE/EA` texture paths, `F`/`C` RGB colors, map grid. Map must be last. On any error: print `Error\n` + message, exit.
2. **Map validation** — map uses only `0`, `1`, `N`, `S`, `E`, `W`; must be surrounded by walls.
3. **Ray-caster** — DDA algorithm casting one ray per screen column; calculate wall distance and projected wall height.
4. **Texturing** — sample the correct XPM texture based on which wall face (N/S/E/W) was hit, and compute the correct texture column/row.
5. **Floor/ceiling** — fill with solid colors from `.cub` file.
6. **Controls** — W/A/S/D move, Left/Right arrows rotate, ESC and window-close quit cleanly.

## .cub File Format

```
NO ./path/to/north_texture.xpm
SO ./path/to/south_texture.xpm
WE ./path/to/west_texture.xpm
EA ./path/to/east_texture.xpm

F 220,100,0
C 225,30,0

1111111
1000001
1000N01
1111111
```

## Norm Constraints

- All code must pass `norminette` (42 Norm): max 25 lines per function, max 5 functions per file, no `for` loops, specific formatting rules.
- Bonus files must use the `_bonus.{c/h}` suffix and be compiled via a separate `bonus` Makefile rule.

## Bonus Features

- Wall collisions
- Minimap
- Doors (open/close)
- Animated sprites
- Mouse look (rotate with mouse)
