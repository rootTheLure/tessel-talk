class CubeDemo

    @rotvecs:
        LEFT:    [0, -1, 0]
        RIGHT:   [0, 1, 0]
        UP:      [0, 0, -1]
        DOWN:    [0, 0, 1]
        FORWARD: [-1, 0, 0]
        BACK:    [1, 0, 0]

    constructor: ->
        do @initScene
        @loadTexture =>
            do @initCube
            do @render

    initScene: ->
        @scene = new THREE.Scene
        @camera = new THREE.PerspectiveCamera 75, window.innerWidth / window.innerHeight, 0.1, 1000
        @renderer = new THREE.WebGLRenderer

        @renderer.setSize window.innerWidth - 16, window.innerHeight
        document.body.appendChild @renderer.domElement

    initCube: ->
        geometry = new THREE.BoxGeometry 1, 1, 1
        material = new THREE.MeshLambertMaterial map:@cubeTexture
        @cube = new THREE.Mesh geometry, material
        light = new THREE.PointLight 0xffffff, 1, 100
        light.position.set 0, 0, 3
        @scene.add light
        @scene.add @cube
        @camera.position.set 0, 0, 2.5

    render: =>
        requestAnimationFrame @render
        @renderer.render @scene, @camera

    loadTexture: (done) ->
        @cubeTexture = THREE.ImageUtils.loadTexture 'js.png', {}, done

    rotate: (direction) ->
        vector = CubeDemo.rotvecs[direction]
        return if not vector
        [x, y, z] = vector
        clearInterval @animInterval
        frameCount = 0
        @animInterval = setInterval (=>
            @cube.rotation.x += x * Math.PI/144
            @cube.rotation.y += y * Math.PI/144
            @cube.rotation.z += z * Math.PI/144
            if ++frameCount is 24
                clearInterval @animInterval
        ), 16.667
