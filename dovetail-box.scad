use <dovetails.scad>;

tail_width = .75;
tail_count = 3;
board_width = 4;
angle = 15;
board_thickness = 0.25;
board_thickness_2 = 0.5;
pin_width = pin_width(tail_width = tail_width, tail_count=tail_count, board_width=board_width);

color( "white" ) translate([board_thickness, 0, 0]) rotate([0, -90, 0])
board_with_dovetail_tails(
    board_length=8,
    board_width=board_width,
    board_thickness=board_thickness,
    tail_length=board_thickness_2,
    tail_width=tail_width,
    pin_width=pin_width,
    tail_count=tail_count,
    angle=angle
);

color( "white" ) translate([6, 0, 0]) rotate([0, -90, 0]) board_with_dovetail_tails(
    board_length=8,
    board_width=board_width,
    board_thickness=board_thickness,
    tail_length=board_thickness_2,
    tail_width=tail_width,
    pin_width=pin_width,
    tail_count=tail_count,
    angle=angle
);

color( "brown" ) translate([0, 8, 0]) rotate([0, 0, -90]) translate([board_thickness_2, 0, 0]) rotate([0, -90, 0])board_with_dovetail_pins(
    board_length=6,
    board_width=board_width,
    board_thickness=board_thickness_2,
    pin_length=board_thickness,
    tail_width=tail_width,
    pin_width=pin_width,
    pin_count = tail_count + 1,
    angle=angle
);

color( "brown" ) translate([6, 0, 0]) rotate([0, 0, 90]) translate([board_thickness_2, 0, 0]) rotate([0, -90, 0])board_with_dovetail_pins(
    board_length=6,
    board_width=board_width,
    board_thickness=board_thickness_2,
    pin_length=board_thickness,
    tail_width=tail_width,
    pin_width=pin_width,
    pin_count = tail_count + 1,
    angle=angle
);