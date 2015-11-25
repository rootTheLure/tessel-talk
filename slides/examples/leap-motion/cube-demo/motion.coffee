class Motion
    constructor: ->
        @controller = new Leap.Controller enableGestures:yes
        @log = new Log 'pre.log'
        @controller.on 'connect', =>
            @log.write 'Leap connected!'

        @controller.on 'ready', =>
            @log.write 'Leap ready!'

        do @controller.connect

        gesture = {}

        @controller.on 'frame', ({gestures}) =>
            swipes = gestures.filter (gesture) -> gesture.type is 'swipe'
            [swipe] = swipes
            if swipes.length > 0
                if swipe.state is 'start'
                    gesture.vector = swipe.direction
                    gesture.count = 1
                else if swipe.state is 'stop'
                    vector = gesture.vector.map (coord) -> coord / gesture.count
                    direction = @vectorToDirection vector
                    @log.write "#{vector.map (item) -> item.toFixed 3} #{direction}\n"
                    @swipeHandler? direction
                else
                    [vx, vy, vz] = gesture.vector
                    [dx, dy, dz] = swipe.direction
                    gesture.vector = [
                        vx + dx
                        vy + dy
                        vz + dz
                    ]
                    gesture.count++

    vectorToDirection: (vector) ->
        [x, y, z] = vector
        absvalIndex = vector.reduce \
            ((acc, coord, index) ->
                if Math.abs(coord) > Math.abs vector[acc]
                    index
                else
                    acc
            ),
            0
        switch absvalIndex
            when 0 # x
                if x > 0
                    Motion.directions.RIGHT
                else
                    Motion.directions.LEFT
            when 1 # y
                if y > 0
                    Motion.directions.UP
                else
                    Motion.directions.DOWN
            when 2 # z
                if z > 0
                    Motion.directions.BACK
                else
                    Motion.directions.FORWARD

    onswipe: (@swipeHandler) ->

    @directions:
        LEFT:    'LEFT'
        RIGHT:   'RIGHT'
        UP:      'UP'
        DOWN:    'DOWN'
        FORWARD: 'FORWARD'
        BACK:    'BACK'

