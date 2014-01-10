module piCameraMicroscopeAdapter() 
{
	function r_from_dia(d) = d / 2;
	function midValue(a,b) = ( a + b ) / 2;

	union() {
		piCameraAdapter();
//		piCameraBackCover(0.1);
//		microscopeAdapter();
//		telescopeAdapter();
	}

	module snap(position,clearance) {
		c = clearance;
		translate(position)
			cube(size=[3+c,3+c,2],center=true);
	}

	module snaps(radius,clearance) {
		r = radius;
		z = 16.0;
		union() {
			snap([ r, 0,z],clearance=clearance);
			snap([ 0, r,z],clearance=clearance);
			snap([-r, 0,z],clearance=clearance);
			snap([ 0,-r,z],clearance=clearance);
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

	module piCameraBackCoverBevel(clearance) {
		c = clearance;
		hw = ( 25 / 2 ) + c;
		he = hw + 1.0;
		polyhedron
			(points = [
				[ hw, -15, -1 ],
				[ hw,  15, -1 ], 
				[ hw,  15,  1 ], 
				[ hw, -15,  1 ],
				[ he, -15, -1 ],
				[ he,  15, -1 ] 
				], 
			triangles = [
				[ 0, 1, 4 ],
				[ 1, 5, 4 ],
				[ 0, 4, 3 ],
				[ 1, 2, 5 ],
				[ 2, 3, 4 ],
				[ 2, 4, 5 ],
				[ 0, 2, 1 ],
				[ 0, 3, 2 ]
			]
		);
	}

	module piCameraBackCoverBevels(clearance) {
		union() {
			piCameraBackCoverBevel(clearance);
			mirror([1,0,0])
				piCameraBackCoverBevel(clearance);
		}
	}

	module piCameraBackCover(clearance) {
		c = 2*clearance;
		translate([0,-5.5,24])
			union() {
				piCameraBackCoverBevels(clearance);
				difference() {
					cube(size=[25+c,30,2],center=true);
					translate([0,12,0])
						cube(size=[20,7,2],center=true);
				}
			}
	}

	module microscopeAdapter() {
		clearance = 0.5;
		inDiameter = 28+clearance;
		exDiameter = 36;
		cylindricAdapter(r_from_dia(inDiameter),r_from_dia(exDiameter),height=20);
	}

	module telescopeAdapter() {
		inDiameter = 33.5;
		exDiameter = 40;
		cylindricAdapter(r_from_dia(inDiameter),r_from_dia(exDiameter),height=20);
	}

	module cableOpening() {
		translate([0,14,3])
			cube(size=[17,12,4],center=true);
	}

	module chipOpening() {
		clearance = 0.5;
		c = 2 * clearance;
		translate([0,-9.5,0])
			cube(size=[8+c,10+c,4],center=true);
	}

	module lensOpening() {
		clearance = 0.5;
		c = 2 * clearance;
		translate([0,0,-2.5])
			cube(size=[8+c,8+c,5], center=true);
	}

	module boardOpening() {
		clearance = 0.5;
		c = 2 * clearance;
		translate([0,-3,2.5])
			cube(size=[25+c,24+c,5], center=true);
	}

	module cameraFrame() {
		translate([0,-0.5,0])
			cube(size=[40,40,10], center=true);
	}

	module piCameraAdapter() {
		difference() {
			translate([0,0,20])
				difference() {
					cameraFrame();
					boardOpening();
					lensOpening();
					cableOpening();
					chipOpening();
				}
			snaps(16,0.2);
			piCameraBackCover(0.5);
		}
	}

}

piCameraMicroscopeAdapter();
