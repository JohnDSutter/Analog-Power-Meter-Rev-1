include <box.scad>;


use_pcb_bnc=0;
use_real_pcb=0;

mmpi=25.4;
pcb_thickness=0.062*mmpi;

sw_ck_w=9.5;
sw_ck_d=6.85;
sw_ck_dia=6.3;
sw_ck_h=12.7;

wall_thickness=3;


pcb_width=50;
pcb_depth=50;
case_width=70;
case_height=91;
//case_depth=95;
case_depth=80;

pcb_offset_x=case_depth-wall_thickness;
pcb_offset_y=(case_width-pcb_width)/2;
pcb_offset_z=5;

meter_back_round_d=48;
meter_back_round2_d=26;
meter_back_round3_d=12;
meter_width=65.5;
meter_height=57;
meter_depth=11;
meter_round_d=20.73;
meter_mount_dist=54.1;
meter_mount_d=3;
meter_front_to_back=11.6;
meter_offset_z=32;

pcb_bnc_d=25.4/2+0.5;
//pcb_bnc_d=10.8;
pcb_bnc_h=25.4;
pcb_bnc_offset_x=-10;
pcb_bnc_offset_y=7.9;
pcb_bnc_offset_z=9.17;

sw_ck_offset_x = -12.65;
sw_ck_offset_y = 42.427;
sw_ck_offset_z =  6.575;

sw_pm_offset_x = 1;
sw_pm_offset_y = 52.427;
sw_pm_offset_z = 12.75+pcb_offset_z;
sw_pm_d=5.8;

bnc_d=9.3;
bnc_flat=0.6;
bnc_x=1;
bnc_y=17.9;
bnc_z=12.75+pcb_offset_z;




module switch() {
  //import("7101MD9AV2BE_fix2a.stl",convexity=1);
  // can't seem to get a usable model of the switch, so..
  color("green") {
    cube([sw_ck_w,sw_ck_d,sw_ck_h]);

    translate([sw_ck_w,sw_ck_d/2,6.35])
      rotate([0,90,0])
        cylinder(d=sw_ck_dia,h=7.32,$fn=50);

    translate([sw_ck_w+5,sw_ck_d/2,6.35])
      rotate([0,75,0])
        cylinder(d=2.4,h=8,$fn=50);
  }
}

module pcb() {
  if (use_real_pcb==1) {
    translate([107.999,-86.1,1])
      rotate([0,0,180])
        scale(1000,1000,1000) import("APM_NF.stl",convexity=1);
  
    translate([-10.7,39,1.8]) switch();

  } else {
    translate([-50,0,0])
      difference() {
        cube([50,50,pcb_thickness]);
        union() {
          translate([50-3.5,50-25.2,-1])
            cylinder(d=3.2,h=pcb_thickness+2,$fn=50);
          translate([50-45.56,50-25.2,-1])
            cylinder(d=3.2,h=pcb_thickness+2,$fn=50);
        }
      }
  }
}



module meter() {
  translate([0,64.5545,-0.3742])
  rotate([0,0,-90])
  color("red") import("85c1_meter.stl",convexity=1);
}

meter_sink=11;

module case_top() {
  difference() {
    intersection() {
  	  // the enclosure itself
  	  box(case_depth,case_width,case_height,wall_thickness,wall_thickness);
  
	  // the case cutaway
	  translate([-25,-1,10])
	    cube([case_depth,case_width+2,case_height]);
    }
	// now for some screw holes to hold the top on
	translate([case_depth-25-7+5-wall_thickness,-1,15])
	  rotate([-90,0,0])
	    cylinder(d=3.0,h=case_width+2,$fn=50);
  }
}




module case_base() {
  difference() {
    union() {
	  // retention features
	  translate([wall_thickness,wall_thickness,0]) 
	    cube([2,case_width-2*wall_thickness,10+2]);
	  //
	  translate([wall_thickness,wall_thickness,0]) 
	    cube([case_depth-25-wall_thickness+3,2,10+2]);
	  translate([wall_thickness,case_width-2*wall_thickness+1,0]) 
	    cube([case_depth-25-wall_thickness+3,2,10+2]);
	  //
	  translate([case_depth-25-wall_thickness+1,wall_thickness,0]) 
	    cube([5,2,case_height-wall_thickness]);
	  translate([case_depth-25-wall_thickness+1,case_width-2*wall_thickness+1,0]) 
	    cube([5,2,case_height-wall_thickness]);
	  //
	  translate([case_depth-25-wall_thickness+1,wall_thickness,case_height-wall_thickness-2]) 
	    cube([5,case_width-2*wall_thickness,2]);
	  //
	  translate([case_depth-25-7-wall_thickness,wall_thickness,0]) 
	    cube([10,5,20]);
	  translate([case_depth-25-7-wall_thickness,case_width-2*wall_thickness-2,0]) 
	    cube([10,5,20]);
	}

	// now for some screw holes to hole the top on
	translate([case_depth-25-7+5-wall_thickness,-1,15])
	  rotate([-90,0,0])
	    cylinder(d=2.5,h=case_width+2,$fn=50);
  }


  difference() {

	union() {
      //
      // things to build up
      //

      // the enclosure itself
      box(case_depth,case_width,case_height,wall_thickness,wall_thickness);

      // build up the case thickness behind the meter
      translate([case_depth-2*wall_thickness-meter_sink,wall_thickness,meter_offset_z-2])
        cube([wall_thickness+meter_sink,case_width-2*wall_thickness,meter_height+2]);

      // standoffs diameter 8mm
      translate([pcb_offset_x-3.5,pcb_offset_y+50-25.2,wall_thickness])
        cylinder(d=8,h=pcb_offset_z,$fn=50);
      translate([pcb_offset_x-45.56,pcb_offset_y+50-25.2,wall_thickness])
        cylinder(d=8,h=pcb_offset_z,$fn=50);


      // front PCB corner supports
      difference() {
        union() {
          translate([pcb_offset_x,pcb_offset_y+50,wall_thickness])
            cylinder(d=8,h=pcb_offset_z+pcb_thickness,$fn=50);
          translate([pcb_offset_x,pcb_offset_y,wall_thickness])
            cylinder(d=8,h=pcb_offset_z+pcb_thickness,$fn=50);
        }
        translate([case_depth,0,wall_thickness])
          cube([10,100,10]);
      }


      // rear PCB corner supports
      translate([pcb_offset_x-50,pcb_offset_y,wall_thickness])
        cylinder(d=8,h=pcb_offset_z+pcb_thickness,$fn=50);
      translate([pcb_offset_x-50,pcb_offset_y+50,wall_thickness])
        cylinder(d=8,h=pcb_offset_z+pcb_thickness,$fn=50);


    }

    union() {
      //
      // things to cut away
      //

      // the case cutaway
      translate([-25,-1,10])
        cube([case_depth,case_width+2,case_height]);

      if (use_pcb_bnc==1) {
        translate([pcb_offset_x+pcb_bnc_offset_x,pcb_offset_y+pcb_bnc_offset_y,pcb_offset_z+pcb_bnc_offset_z+pcb_thickness+wall_thickness])
          rotate([0,90,0]) color("red")
            cylinder(d=pcb_bnc_d,h=40,$fn=50);

        translate([pcb_offset_x+sw_ck_offset_x,pcb_offset_y+sw_ck_offset_y,pcb_offset_z+sw_ck_offset_z+pcb_thickness+wall_thickness])
          rotate([0,90,0]) color("red")
            cylinder(d=sw_ck_dia+0.5,h=40,$fn=50);

      } else {
        // hole for BNC connector
        translate([case_depth+bnc_x,bnc_y,bnc_z]) {
          rotate([90,-90,0])
            difference() {
              rotate([-90,0,0])
                cylinder(r=bnc_d/2,h=wall_thickness+2,$fn=40);
              translate([bnc_d/2-bnc_flat,-1,-bnc_d/2]) 
                cube([bnc_flat,bnc_d,bnc_d]);
            }
        }

        translate([case_depth+sw_pm_offset_x,sw_pm_offset_y,sw_pm_offset_z]) {
          rotate([0,-90,0])
            cylinder(d=sw_pm_d+0.5,h=wall_thickness+2,$fn=40);
        }
        // a little hole to catch the alignment tab
        translate([case_depth+sw_pm_offset_x-3,sw_pm_offset_y-7,sw_pm_offset_z]) {
          rotate([0,-90,0])
            cylinder(d=3,h=2,$fn=40);
        }

      }


      // notches in the PCB support
      translate([-50-0.25+pcb_offset_x,pcb_offset_y-0.25,wall_thickness+pcb_offset_z])
        cube([50.25,50.5,pcb_thickness+1]);

      // standoff holes
      translate([pcb_offset_x-3.5,pcb_offset_y+50-25.2,wall_thickness])
        cylinder(d=2.75,h=pcb_offset_z+15,$fn=50);
      translate([pcb_offset_x-45.56,pcb_offset_y+50-25.2,wall_thickness])
        cylinder(d=2.75,h=pcb_offset_z+15,$fn=50);

      // access hole through the meter slot to tighten the front pcb mount screw..
      translate([pcb_offset_x-3.5+-1,pcb_offset_y+50-25.2,wall_thickness+pcb_offset_z+1])
        rotate([0,10,0])
          cylinder(d=5,h=pcb_offset_z+45,$fn=50);
//      translate([pcb_offset_x-3.5+3,pcb_offset_y+50-25.2,wall_thickness+pcb_offset_z])
//          cylinder(d=5,h=pcb_offset_z+45,$fn=50);

      // a cutout for the meter
      translate([case_depth-0*wall_thickness-meter_sink,(case_width-meter_width)/2,meter_offset_z])
		cube([meter_depth+1,meter_width,meter_height]);

      // let's make a hole for the meter back, 6 holes all-in-all..
      translate([case_depth-0*wall_thickness-meter_sink,(case_width-meter_width)/2,meter_offset_z]) {
        translate([1,meter_width/2,2+meter_back_round_d/2]) 
          rotate([0,-90,0])
            cylinder(d=meter_back_round_d+0.5,h=wall_thickness+5,$fn=50);

        // mounting screw holes
        translate([0.75,(meter_width+52)/2,2+10.25+meter_mount_d/2]) 
          rotate([0,-90,0])
            cylinder(d=meter_mount_d+0.75,h=2*wall_thickness+2,$fn=50);
        translate([0.75,(meter_width-52)/2,2+10.25+meter_mount_d/2]) 
          rotate([0,-90,0])
            cylinder(d=meter_mount_d+0.75,h=2*wall_thickness+2,$fn=50);
        // washers for the mounting screws
        translate([-wall_thickness-2,(meter_width+52)/2,2+10.25+meter_mount_d/2]) 
          rotate([0,-90,0])
            cylinder(d=8,h=2,$fn=50);
        translate([-wall_thickness-2,(meter_width-52)/2,2+10.25+meter_mount_d/2]) 
          rotate([0,-90,0])
            cylinder(d=8,h=2,$fn=50);
      }
    }
  }

}


//translate([case_depth+meter_front_to_back-meter_sink,wall_thickness,meter_offset_z]) meter();
//translate([pcb_offset_x,pcb_offset_y,pcb_offset_z+wall_thickness]) pcb();

color("gray") case_base();
 
//case_top();

//top();
//color("red") bottom();

//color("green") translate([pcb_offset_x,pcb_offset_y,pcb_offset_z]) pcb();

//translate([sw_cal_x+sw_cal_width/2+pcb_offset_x,sw_cal_y+sw_cal_depth/2+pcb_offset_y, sw_cal_button_top+0.5]) cal_plunger();

//translate([sw_rit_x+sw_rit_width/2+pcb_offset_x,sw_rit_y+sw_rit_depth/2+pcb_offset_y, top_height-wall_thickness-2]) sw_rit_cap();

