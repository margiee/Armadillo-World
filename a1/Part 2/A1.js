/*
 * UBC CPSC 314, Vsep2017
 * Assignment 1 Template
 */

// SETUP RENDERER & SCENE
var canvas = document.getElementById('canvas');
var scene = new THREE.Scene();
var renderer = new THREE.WebGLRenderer();
renderer.setClearColor(0xFFFFFF); // white background colour
canvas.appendChild(renderer.domElement);

// SETUP CAMERA
var camera = new THREE.PerspectiveCamera(30,1,0.1,1000); // view angle, aspect ratio, near, far
camera.position.set(45,20,40);
camera.lookAt(scene.position);
scene.add(camera);

// SETUP ORBIT CONTROLS OF THE CAMERA
var controls = new THREE.OrbitControls(camera);
controls.damping = 0.2;
controls.autoRotate = false;

// ADAPT TO WINDOW RESIZE
function resize() {
  renderer.setSize(window.innerWidth,window.innerHeight);
  camera.aspect = window.innerWidth/window.innerHeight;
  camera.updateProjectionMatrix();
}

// EVENT LISTENER RESIZE
window.addEventListener('resize',resize);
resize();

//SCROLLBAR FUNCTION DISABLE
window.onscroll = function () {
     window.scrollTo(0,0);
   }

// WORLD COORDINATE FRAME: other objects are defined with respect to it
var worldFrame = new THREE.AxisHelper(5) ;
scene.add(worldFrame);

// FLOOR WITH PATTERN
var floorTexture = new THREE.ImageUtils.loadTexture('images/floor.jpg');
floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping;
floorTexture.repeat.set(1, 1);

var floorMaterial = new THREE.MeshBasicMaterial({ map: floorTexture, side: THREE.DoubleSide });
var floorGeometry = new THREE.PlaneBufferGeometry(30, 30);
var floor = new THREE.Mesh(floorGeometry, floorMaterial);
floor.position.y = -0.1;
floor.rotation.x = Math.PI / 2;
scene.add(floor);
floor.parent = worldFrame;

/////////////////////////////////
//   YOUR WORK STARTS BELOW    //
/////////////////////////////////

// UNIFORMS
var lightPosition = {type: 'v3', value: new THREE.Vector3(0,5,3)};
var cubePosition = {type: 'v3', value: new THREE.Vector3(0, 3, -5)};
var cube2Position = {type: 'v3', value: new THREE.Vector3(0, 3, 5)};
var cube3Position = {type: 'v3', value: new THREE.Vector3(5, 3, 0)};
var cube4Position = {type: 'v3', value: new THREE.Vector3(-5, 3, 0)};

var cubeAngle = {type: 'f', value: 1.0};
var cube2Angle = {type: 'f', value: 1.0};
var cube3Angle = {type: 'f', value: 1.0};
var cube4Angle = {type: 'f', value: 1.0};

// MATERIALS
var armadilloMaterial = new THREE.ShaderMaterial({
	uniforms: {
		lightPosition: lightPosition,
	},
});
var lightbulbMaterial = new THREE.ShaderMaterial({
   uniforms: {
    lightPosition: lightPosition,
	cubePosition: cubePosition,
	cube2Position: cube2Position,
	cube3Position: cube3Position,
	cube4Position: cube4Position,
  },
});

// CUBE MATERIALS
var cubeMaterial = new THREE.ShaderMaterial({
	uniforms: {
		cubePosition: cubePosition,
		lightPosition: lightPosition,
		cubeAngle: cubeAngle,
	},
});

var cube2Material = new THREE.ShaderMaterial({
	uniforms: {
		cube2Position: cube2Position,
		lightPosition: lightPosition,
		cube2Angle: cube2Angle,
	},
});

var cube3Material = new THREE.ShaderMaterial({
	uniforms: {
		cube3Position: cube3Position,
		lightPosition: lightPosition,
		cube3Angle: cube3Angle,
	},
});

var cube4Material = new THREE.ShaderMaterial({
	uniforms: {
		cube4Position: cube4Position,
		lightPosition: lightPosition,
		cube4Angle: cube4Angle,
	},
});

// LOAD SHADERS
var shaderFiles = [
  'glsl/armadillo.vs.glsl',
  'glsl/armadillo.fs.glsl',
  'glsl/lightbulb.vs.glsl',
  'glsl/lightbulb.fs.glsl',
  'glsl/cube.vs.glsl',
  'glsl/cube.fs.glsl',
  'glsl/cube2.vs.glsl',
  'glsl/cube2.fs.glsl',
  'glsl/cube3.vs.glsl',
  'glsl/cube3.fs.glsl',
  'glsl/cube4.vs.glsl',
  'glsl/cube4.fs.glsl'
];

new THREE.SourceLoader().load(shaderFiles, function(shaders) {
  armadilloMaterial.vertexShader = shaders['glsl/armadillo.vs.glsl'];
  armadilloMaterial.fragmentShader = shaders['glsl/armadillo.fs.glsl'];

  lightbulbMaterial.vertexShader = shaders['glsl/lightbulb.vs.glsl'];
  lightbulbMaterial.fragmentShader = shaders['glsl/lightbulb.fs.glsl'];
  
  cubeMaterial.vertexShader = shaders['glsl/cube.vs.glsl'];
  cubeMaterial.fragmentShader = shaders['glsl/cube.fs.glsl'];
  
  cube2Material.vertexShader = shaders['glsl/cube2.vs.glsl'];
  cube2Material.fragmentShader = shaders['glsl/cube2.fs.glsl'];
  
  cube3Material.vertexShader = shaders['glsl/cube3.vs.glsl'];
  cube3Material.fragmentShader = shaders['glsl/cube3.fs.glsl'];

  cube4Material.vertexShader = shaders['glsl/cube4.vs.glsl'];
  cube4Material.fragmentShader = shaders['glsl/cube4.fs.glsl'];
})

// LOAD ARMADILLO
function loadOBJ(file, material, scale, xOff, yOff, zOff, xRot, yRot, zRot) {
  var onProgress = function(query) {
    if ( query.lengthComputable ) {
      var percentComplete = query.loaded / query.total * 100;
      console.log( Math.round(percentComplete, 2) + '% downloaded' );
    }
  };

  var onError = function() {
    console.log('Failed to load ' + file);
  };

  var loader = new THREE.OBJLoader();
  loader.load(file, function(object) {
    object.traverse(function(child) {
      if (child instanceof THREE.Mesh) {
        child.material = material;
      }
    });

    object.position.set(xOff,yOff,zOff);
    object.rotation.x= xRot;
    object.rotation.y = yRot;
    object.rotation.z = zRot;
    object.scale.set(scale,scale,scale);
    object.parent = worldFrame;
    scene.add(object);

  }, onProgress, onError);
}

loadOBJ('obj/armadillo.obj', armadilloMaterial, 3, 0,3,0, 0,Math.PI,0);

// CREATE light
var lightbulbGeometry = new THREE.SphereGeometry(2, 50, 50);
var lightbulb = new THREE.Mesh(lightbulbGeometry, lightbulbMaterial);
lightbulb.parent = worldFrame;
scene.add(lightbulb);

// CREATE cube
var cubeGeometry = new THREE.CubeGeometry(4, 4, 4);
var cube = new THREE.Mesh(cubeGeometry, cubeMaterial);
cube.parent = worldFrame;
scene.add(cube);

// CREATE second cube
var cube2Geometry = new THREE.CubeGeometry(2, 2, 2);
var cube2 = new THREE.Mesh(cube2Geometry, cube2Material);
cube2.parent = worldFrame;
scene.add(cube2);

// CREATE third cube
var cube3Geometry = new THREE.CubeGeometry(3, 3, 3);
var cube3 = new THREE.Mesh(cube3Geometry, cube3Material);
cube3.parent = worldFrame;
scene.add(cube3);

// CREATE fourth cube
var cube4Geometry = new THREE.CubeGeometry(5, 5, 5);
var cube4 = new THREE.Mesh(cube4Geometry, cube4Material);
cube4.parent = worldFrame;
scene.add(cube4);


// LISTEN TO KEYBOARD
var keyboard = new THREEx.KeyboardState();
function checkKeyboard() {
  if (keyboard.pressed("W"))
    lightPosition.value.z -= 0.1;
  else if (keyboard.pressed("S"))
    lightPosition.value.z += 0.1;

  if (keyboard.pressed("A"))
    lightPosition.value.x -= 0.1;
  else if (keyboard.pressed("D"))
    lightPosition.value.x += 0.1;

  lightbulbMaterial.needsUpdate = true; // Tells three.js that some uniforms might have changed
}


// rotates cubes
function rotateCube(){
	cubeAngle.value = (Date.now()*0.001)%100;
	cubeMaterial.needsUpdate = true;
} 

function rotateCube2(){
	cube2Angle.value = (Date.now()*0.002)%360;
	cube2Material.needsUpdate = true;
}

function rotateCube3(){
	cube3Angle.value = (Date.now()*0.004)%360;
	cube3Material.needsUpdate = true;
}

function rotateCube4(){
	cube4Angle.value = (Date.now()*0.006)%360;
	cube4Material.needsUpdate = true;
}

// SETUP UPDATE CALL-BACK
function update() {
  checkKeyboard();
  rotateCube();
  rotateCube2();
  rotateCube3();
  rotateCube4();
  requestAnimationFrame(update);
  renderer.render(scene, camera);
}

update();

