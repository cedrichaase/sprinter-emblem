$fn=200;

module base() {
    import("./pacifik_mers.stl");
    translate([0, 0, 3]) cylinder(h=2, d=120);
}

module dome(d=120) {
    sphere_z_factor=1/10;
    sphere_height=sphere_z_factor*d;
    translate([0, 0, sphere_height/2 - 2.5]) difference() {
        scale([1, 1, sphere_z_factor]) sphere(d=d);
        translate([0, 0, -sphere_height/2]) cylinder(h=sphere_height/2, d=d);
    }
}

module border() {
    translate([0, 0, 5]) difference() {
        cylinder(h=3, d=120);
        cylinder(h=3, d=110);
    }
}

module logo() {
    rotate([0 ,0, 0]) translate([0, 0, 0]) intersection() {
        translate([0, 0, 2]) dome();
        logo2();
    }
}

// linear_extrude(height=15) scale(1/3) import(file="./mountain-logo.svg", center=true);


module logo2() {
h=15;
w=10;
translate([-60, -w/2, 0]) cube([120, w, h]);
rotate([0, 0, 45]) translate([0, -w/2, 0]) cube([60, w, h]);
rotate([0, 0, -45]) translate([0, -w/2, 0]) cube([60, w, h]);
}

//logo2();


dome();
border();
base();
logo();
