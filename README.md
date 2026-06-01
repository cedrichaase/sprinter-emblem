# Sprinter / Crafter Emblem

A parametric OpenSCAD library for creating custom rear emblems for the **Mercedes-Benz Sprinter** and **VW Crafter**. Bring your own SVG logo and get a print-ready emblem that fits the stock mounting points.

## What it produces

A ~120mm circular emblem with:
- a domed, slightly convex face
- your logo raised on that curved surface
- a clean border ring
- a separate mounting washer

Designed to be printed in PETG.

## Requirements

- [OpenSCAD](https://openscad.org/) (2021.01 or later recommended for SVG import support)
- A slicer such as PrusaSlicer or BambuStudio

## Usage

1. Place your SVG logo in the project directory.
2. In `emblem.scad`, replace the `logo2()` call with an SVG import:

```scad
module logo() {
    intersection() {
        translate([0, 0, 2]) dome();
        linear_extrude(height=15) scale(1/3) import(file="./your-logo.svg", center=true);
    }
}
```

3. Preview and export:

```bash
openscad emblem.scad                # live preview
openscad -o emblem.stl emblem.scad  # export for slicing
openscad -o washer.stl washer.scad  # export mounting washer
```

4. Slice and print both parts in PETG.

## SVG tips

- Center your artwork at the origin in your vector editor before exporting.
- The emblem face is 120mm in diameter; design at roughly 360mm wide and let the `scale(1/3)` in the import handle the resize, or adjust the scale factor to taste.
- Simple, bold shapes work best — fine detail gets lost at this scale.

## Files

| File | Description |
|---|---|
| `emblem.scad` | Main emblem model |
| `washer.scad` | Mounting washer (r=12mm / r=4.2mm) |
| `pacifik_mers.stl` | Base star geometry (source asset) |
| `mountain-logo.svg` | Example SVG input |

## Example

`mountain-logo.svg` is included as a reference — a simple mountain/landscape design that demonstrates how an SVG is mapped onto the domed surface.
