module piCameraMicroscopeAdapter() 
{
	function r_from_dia(d) = d / 2;
   function midValue(a,b) = ( a + b ) / 2;

	union() {
		piCameraAdapter();
//		microscopeAdapter();
//		telescopeAdapter();
	}

	module snap(position,clearance) {
		c = clearance;
		translate(position)
			cube(size=[3+c,3+c,3],center=true);
	}

	module snaps(radius,clearance) {
		r = radius;
		union() {
			snap([ r, 0,16.5],clearance=clearance);
			snap([ 0, r,16.5],clearance=clearance);
			snap([-r, 0,16.5],clearance=clearance);
			snap([ 0,-r,16.5],clearance=clearance);
		}
	}

	module cylindricAdapter(inRadius,exRadius,height) {
		midRadius = midValue(exRadius,inRadius);
		union() {
			translate([0,0,5])
				difference() {
   					cylinder(r=exRadius, h=height, center=true);
			   	   cylinder(r=inRadius, h=height, center=true);
				}

         snaps(midRadius,-0.2);
		}
	}

	module microscopeAdapter() {
		inDiameter = 28;
		exDiameter = 36;
		cylindricAdapter(r_from_dia(inDiameter),r_from_dia(exDiameter),height=20);
	}

	module telescopeAdapter() {
		inDiameter = 33.5;
		exDiameter = 40;
		cylindricAdapter(r_from_dia(inDiameter),r_from_dia(exDiameter),height=20);
	}

	module cableOpening() {
		translate([0,18,23])
			cube(size=[17,12,4],center=true);
	}

	module piCameraAdapter() {
		difference() {
			translate([0,0,20])
				difference() {
					translate([0,-0.5,0])
						cube(size=[40,40,10], center=true);
					translate([0,-3,2.5])
						cube(size=[25,25,5], center=true);
					translate([0,0,-2.5])
						cube(size=[8,8,5], center=true);
			}
	
      snaps(16,0.2);

		translate([0,-3,0])
			cableOpening();
	}
  }

}

piCameraMicroscopeAdapter();