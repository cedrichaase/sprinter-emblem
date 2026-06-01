$fn=200;

svg_file        = "./peace.svg";
emblem_d        = 120;
protrude        = 2;      // mm logo protrudes above dome surface

// potrace outputs SVG with pt units matching the input BMP pixel count
// peace.svg: 1000pt → 1000*(25.4/72) = 352.78mm in OpenSCAD
svg_mm          = 1000 * (25.4 / 72);
// Peace symbol outer ring is at r=430 in a 1000px BMP → 430/500 of SVG half-width.
// Scale up so the outer ring lands exactly at the emblem edge.
logo_d          = emblem_d * (500.0 / 430.0);
logo_scale      = logo_d / svg_mm;

sphere_z_factor = 1/10;

module base() {
    import("./pacifik_mers.stl");
    translate([0, 0, 3]) cylinder(h=2, d=emblem_d);
}

module dome(d=emblem_d, z_factor=sphere_z_factor) {
    sphere_height = z_factor * d;
    translate([0, 0, sphere_height/2 - 2.5]) difference() {
        scale([1, 1, z_factor]) sphere(d=d);
        translate([0, 0, -sphere_height/2]) cylinder(h=sphere_height/2, d=d);
    }
}

module logo_extrude(h=20) {
    rotate([0, 0, 90])
    scale([logo_scale, logo_scale, 1])
        translate([-svg_mm/2, -svg_mm/2, 0])
            linear_extrude(height=h)
                import(file=svg_file);
}

module emblem() {
    base();
    union() {
        dome();
        // Uniform protrusion: outer shell is the same dome shifted up by `protrude` mm,
        // so the gap between inner and outer surface is exactly `protrude` everywhere.
        intersection() {
            logo_extrude(h=20);
            difference() {
                translate([0, 0, protrude]) dome();
                dome();
            }
        }
    }
}

emblem();
