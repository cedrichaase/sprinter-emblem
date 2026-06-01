$fn=200;

svg_file  = "./vt-logo.svg";
emblem_d  = 120;

// potrace outputs SVG with pt units (250pt = 88.194mm in OpenSCAD)
svg_mm    = 250 * (25.4 / 72);   // actual size of SVG in OpenSCAD mm space
logo_d    = emblem_d - 12;        // target logo diameter (fits inside border)
logo_scale = logo_d / svg_mm;

module base() {
    import("./pacifik_mers.stl");
    translate([0, 0, 3]) cylinder(h=2, d=emblem_d);
}

module dome(d=emblem_d) {
    sphere_z_factor = 1/10;
    sphere_height   = sphere_z_factor * d;
    translate([0, 0, sphere_height/2 - 2.5]) difference() {
        scale([1, 1, sphere_z_factor]) sphere(d=d);
        translate([0, 0, -sphere_height/2]) cylinder(h=sphere_height/2, d=d);
    }
}

module border() {
    translate([0, 0, 5]) difference() {
        cylinder(h=3, d=emblem_d);
        cylinder(h=3, d=emblem_d - 10);
    }
}

// SVG logo extruded and centered at origin
module logo_extrude(h=15) {
    scale([logo_scale, logo_scale, 1])
        translate([-svg_mm/2, -svg_mm/2, 0])
            linear_extrude(height=h)
                import(file=svg_file);
}

module emblem() {
    base();
    border();
    // Dome with logo cut in as negative relief
    difference() {
        dome();
        logo_extrude();
    }
}

emblem();
