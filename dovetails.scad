/**
 * pin_length is measured along the same axis as the length of the board.
 * pin_width is the width of the bottom of the pins, where they're widest.
 * pin_thickness is measured along the same axis as the board thickness.
 * tail_width is the width of the tails where they meet the bottom of the pins, where they're narrowest.
 */
module dovetail_pins(pin_length=.75, pin_width=1, pin_thickness=.75, pin_count=4, angle=15, tail_width=1) {
    intersection() {
        translate([0.005, 0.005, 0.005]) cube([(pin_count-1)*(pin_width+tail_width)-0.01, pin_length-0.01, pin_thickness-0.01]);
        dovetail_pins_idealized(
            pin_length=pin_length,
            pin_width=pin_width,
            pin_thickness=pin_thickness,
            pin_count=pin_count,
            angle=angle,
            tail_width=tail_width
        );
    }
}

/**
 * tail_length is measured along the same axis as the length of the board.
 * tail_width is the width of the tails where they meet the board, where they're narrowest.
 * tail_thickness is measured along the same axis as the board thickness.
 * pin_width is the width of the bottom of the pins, where they're widest.
 */
module dovetail_tails(tail_length=.75, tail_width=1, tail_thickness=.75, tail_count=3, angle=15, pin_width=1) {
    pin_count = tail_count + 1;
    pin_thickness = tail_length;
    pin_length = tail_thickness;
    
    translate([0, 0, tail_thickness]) {
        rotate([-90, 0, 0]) {
            translate([0, 0, -0.005]) {
                difference() {
                    translate([0.005, 0.005, 0.005]) {
                        cube([(pin_count-1)*(pin_width+tail_width)-0.01, tail_thickness-0.01, tail_length-0.01]);
                    }

                    dovetail_pins_idealized(
                        pin_length=pin_length,
                        pin_width=pin_width,
                        pin_thickness=pin_thickness,
                        pin_count=pin_count,
                        angle=angle,
                        tail_width=tail_width
                    );
                }
            }
        }
    }
}

/**
 * Used for generating both pins and tails. Don't call this directly.
 */
module dovetail_pins_idealized(
    pin_length=.75,
    pin_width=1,
    pin_thickness=.75,
    pin_count=4,
    angle=15,
    tail_width=1) {
        
    pin_width_top = pin_width - ( 2 * tan(angle) * pin_thickness );
    
    translate([0, pin_length, 0]) {
        rotate([90, 0, 0]) {
            intersection() {
                cube([(pin_count-1)*(pin_width+tail_width), pin_thickness, pin_length]);
                
                for (pin = [0:pin_count-1]) {
                    translate([pin * (pin_width + tail_width), 0]) {
                        linear_extrude(pin_length) {
                            polygon([
                                [-pin_width/2, 0], 
                                [-pin_width_top/2, pin_thickness],
                                [pin_width_top/2, pin_thickness],
                                [pin_width/2, 0]
                            ]);
                        }
                    }
                }
            }
        }
    }
}

/**
 * Determine the width the pins need to be once the tail widths are chosen.
 */
function pin_width (tail_width, tail_count, board_width) = ( board_width - (tail_width * tail_count) ) / (tail_count);

/**
 * Construct a board with tails cut into it. board_length includes the length of the tails.
 */
module board_with_dovetail_tails(board_length, board_width, board_thickness, tail_length, tail_width, pin_width, tail_count, angle) {
    
    tail_thickness = board_thickness;
    
    pin_width = pin_width(tail_width = tail_width, tail_count=tail_count, board_width=board_width);
    translate([0, board_length - ( 2 * tail_length) + tail_length, 0]) {
        dovetail_tails(tail_length=tail_length, tail_width=tail_width, tail_thickness=tail_thickness, tail_count=tail_count, angle=angle, pin_width=pin_width);
    }
    translate([0, tail_length, 0]) cube([board_width, board_length - ( 2 * tail_length), board_thickness]);
    translate([0, tail_length, 0]) mirror([0,1,0]) dovetail_tails(tail_length=tail_length, tail_width=tail_width, tail_thickness=tail_thickness, tail_count=tail_count, angle=angle, pin_width=pin_width);
}

/**
 * Construct a board with pins cut into it. board_length includes the length of the pins.
 */
module board_with_dovetail_pins(board_length, board_width, board_thickness, pin_length, tail_width, pin_width, pin_count, angle) {
    translate([0, board_length - ( 2 * pin_length) + pin_length, 0]) {
        dovetail_pins(pin_length=pin_length, pin_width=pin_width, pin_thickness=board_thickness, pin_count=pin_count, angle=angle, tail_width=tail_width);
    }
    translate([0, pin_length, 0]) cube([board_width, board_length - ( 2 * pin_length), board_thickness]);
        dovetail_pins(pin_length=pin_length, pin_width=pin_width, pin_thickness=board_thickness, pin_count=pin_count, angle=angle, tail_width=tail_width);
}

// An example set of boards.
tail_width = .75;
tail_count = 3;
board_width = 4;
angle = 15;
board_thickness = 0.5;
pin_width = pin_width(tail_width = tail_width, tail_count=tail_count, board_width=board_width);

board_with_dovetail_tails(
    board_length=8,
    board_width=board_width,
    board_thickness=board_thickness,
    tail_length=.5,
    tail_width=tail_width,
    pin_width=pin_width,
    tail_count=tail_count,
    angle=angle
);

translate([board_width + 1, 0, 0]) board_with_dovetail_pins(
    board_length=6,
    board_width=board_width,
    board_thickness=board_thickness,
    pin_length=.5,
    tail_width=tail_width,
    pin_width=pin_width,
    pin_count = tail_count + 1,
    angle=angle
);