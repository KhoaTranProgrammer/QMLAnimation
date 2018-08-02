import QtQuick 2.3
import QtGraphicalEffects 1.0

Item {
    id: world
    width: 1400
    height: 700

    property int worldTime: 10000 // 10 seconds

    // Create the array to store the new stars
    QtObject {
        id: data
        property var stars: []
    }

    // This is the sky
    Rectangle {
        id: sky
        anchors.fill: parent
        color: "indigo"
        z: -1

        // Animation on sky's color
        SequentialAnimation on color {
            loops: Animation.Infinite

            // Morning
            ColorAnimation {
                to: "light blue"
                duration: worldTime * 0.3
            }

            // Afternoon
            PauseAnimation { duration: worldTime * 0.4 }

            // Night
            ColorAnimation {
                to: "indigo"
                duration: worldTime * 0.3
            }
        }
    }

    // This is the mountain
    Image {
        id: mountain
        source: "mountain.png"
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height * 0.8
    }

    // This is the sea
    Rectangle {
        id: sea
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: world.height * 0.05

        // Sea is a group of Gradient and ColorAnimation
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(world.width, 0)
            gradient: Gradient {
                GradientStop {
                    position: 0.0;
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#E1F5FE"; to: "#B3E5FC"; duration: 1000 }
                    }
                }
                GradientStop {
                    position: 0.25;
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#B3E5FC"; to: "#81D4FA"; duration: 1000 }
                    }
                }
                GradientStop {
                    position: 0.5;
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#81D4FA"; to: "#4FC3F7"; duration: 1000 }
                    }
                }
                GradientStop {
                    position: 0.75;
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#4FC3F7"; to: "#29B6F6"; duration: 1000 }
                    }
                }
                GradientStop {
                    position: 1.0;
                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "#29B6F6"; to: "#03A9F4"; duration: 1000 }
                    }
                }
            }
        }
    }

    // This is the sun
    Rectangle {
        id: sun
        width: world.width * 0.05
        height: width
        x: 0
        y: world.height * 0.3
        radius: width / 2
        color: "red"

        // Animation to make the sun rise and down
        SequentialAnimation on y {
            running: true
            loops: Animation.Infinite

            // Sun rise in the morning
            NumberAnimation {
                from: world.height
                to: world.height * 0.3
                duration: worldTime * 0.3
            }

            // Sun keep in the afternoon
            PauseAnimation { duration: worldTime * 0.4 }

            // Sun down in the evening
            NumberAnimation {
                from: world.height * 0.3
                to: world.height
                duration: worldTime * 0.3
            }
        }

        // Animation to change the sun's color
        SequentialAnimation on color {
            running: true
            loops: Animation.Infinite

            // Morning
            ColorAnimation {
                to: "yellow"
                duration: worldTime * 0.3
            }

            // Afternoon
            PauseAnimation { duration: worldTime * 0.4 }

            // Night
            ColorAnimation {
                to: "red"
                duration: worldTime * 0.3
            }
        }
    }

    // This is the clouds group
    Cloud {
        id: cloud1; mWorldTime: worldTime; x: 100; y: 100; width: 160; height: 100; z: 1
    }
    Cloud {
        id: cloud2; mWorldTime: worldTime; x: 200; y: 300; width: 240; height: 100; z: -1

        // State for updating parent of cloud2
        states: State {
            name: "reparented"
            ParentChange { target: cloud2; parent: mountain; x: mountain.width / 3; }
        }

        // The transition when the state of cloud2 changes
        transitions: Transition {
            // Animation when changing parent of cloud2
            ParentAnimation {
                NumberAnimation { properties: "x"; duration: worldTime * 0.5 }
            }
        }

        // Changes the state of cloud2
        MouseArea { anchors.fill: parent; onClicked: cloud2.state = "reparented" }
    }
    Cloud {
        id: cloud3; mWorldTime: worldTime; x: 400; y: 180; width: 200; height: 140; z: 1
    }
    Cloud {
        id: cloud4; mWorldTime: worldTime; x: 700; y: 280; width: 180; height: 120; z: -1
    }
    Cloud {
        id: cloud5; mWorldTime: worldTime; x: 900; y: 180; width: 380; height: 140; z: 1
    }

    // This is the boat
    Image {
        id: boat
        source: "boat.png"
        anchors {
            bottom: parent.bottom
            bottomMargin: world.height * 0.025
        }
        x: 0
        height: world.height * 0.2
        fillMode: Image.PreserveAspectFit

        // Timer to update the rotation of boat for up&down in repeatedly
        Timer {
            interval: worldTime / 10;
            running: true;
            repeat: true
            onTriggered: {
                if(boat.rotation == 15) boat.rotation = -15
                else boat.rotation = 15
            }
        }

        // Add Behavior when rotation change
        Behavior on rotation {
            // Animation to smoothly change the rotation
            SmoothedAnimation { velocity: 30 }
        }
    }

    // This is the moon
    Image {
        id: moon
        source: "moon.png"
        x: world.width
        y: 0
        height: world.height * 0.15
        fillMode: Image.PreserveAspectFit

        // Timer to appear/disappear the moon
        Timer {
            interval: worldTime * 0.5
            running: true
            repeat: true
            onTriggered: {
                if(moon.y <= moon.height){ // Moon will appear in the night
                    moon.x = world.width * 0.7
                    moon.y = world.height * 0.2

                    // Dynamically create Star objects when the Moon appears
                    for(var i = 0; i < 200; i++){
                        var newX = Math.floor(Math.random() * world.width)
                        var newY = Math.floor(Math.random() * world.height * 0.9)
                        data.stars.push
                                (
                                    starCreator.createObject(world,
                                    {
                                        x: newX,
                                        y: newY,
                                        width: 10,
                                        height: 10
                                    }
                                ))
                    }

                }else{ // Moon will disappear in the day
                    moon.x = world.width
                    moon.y = 0

                    // Destroy all stars
                    for(var i = 0; i < 200; i++){
                        var result = data.stars.pop()
                        result.remove()
                    }
                }
            }
        }

        // Add Behavior when the moon location change
        Behavior on x {
            // Apply SpringAnimation when x change
            SpringAnimation { spring: 2; damping: 1.0 }
        }
        Behavior on y {
            // Apply SpringAnimation when y change
            SpringAnimation { spring: 2; damping: 1.0 }
        }
    }

    // Dynamically create Star object by using Component QML type
    Component {
        id: starCreator
        Star {}
    }

    // A pair of birds
    Bird {
        id: bird
        x: world.width - 100
        y: world.height / 2
        width: world.width * 0.1
        height: bird.width * 0.5
    }
    Bird {
        id: bird2
        x: world.width - 120
        y: world.height / 2
        width: world.width * 0.1
        height: bird2.width * 0.5
    }

    // Animation to move the sun in horizontal
    PropertyAnimation {
        target: sun
        loops: Animation.Infinite
        property: "x"
        from: 0
        to: world.width
        duration: worldTime
        running: true
        easing.type: Easing.InOutQuad
    }

    // Animation to change the sun's size
    NumberAnimation {
        target: sun
        loops: Animation.Infinite
        property: "scale"
        from: 1; to: 1.5
        duration: worldTime
        running: true
    }

    // Animation to rotate the cloud4
    PropertyAnimation {
        target: cloud4
        loops: Animation.Infinite
        property: "rotation"
        from: 0
        to: 360
        duration: worldTime
        running: true
        easing.type: Easing.OutInCubic
    }

    // Animation to many clouds
    ParallelAnimation {
        running: true
        loops: Animation.Infinite

        // Animation to change the cloud1's size
        NumberAnimation {
            target: cloud1
            property: "scale"
            from: 1; to: 2
            duration: worldTime
            easing.type: Easing.InOutQuart
        }

        // Animation to change the cloud5's size
        NumberAnimation {
            target: cloud5
            property: "scale"
            from: 1; to: 0.2
            duration: worldTime
            easing.type: Easing.InOutQuart
        }
    }

    // Animation to cloud3
    ParallelAnimation {
        running: true
        loops: Animation.Infinite

        // Animation to move the cloud3 in horizontal
        NumberAnimation {
            target: cloud3
            property: "x"
            from: cloud3.x
            to: world.width
            duration: worldTime
        }

        // Animation to move the cloud3 in vertical
        NumberAnimation {
            target: cloud3
            property: "y"
            from: cloud3.y
            to: 0
            duration: worldTime
        }
    }

    // Animation to rotate the cloud1
    RotationAnimation {
        target: cloud1
        loops: Animation.Infinite
        duration: worldTime
        from: 360
        to: 0
        running: true
    }

    // List of state for boat
    states: [
        State { // From left -> right
            name: "reanchored_right"
            AnchorChanges { target: boat; anchors.right: world.right }
        },
        State { // From right -> left
            name: "reanchored_left"
            AnchorChanges { target: boat; anchors.left: world.left }
        }
    ]

    // The transition when the state of boat changes
    transitions: Transition {
        // Animation when changing anchor of boat
        AnchorAnimation { duration: worldTime }
    }

    // Default event to change state of boat from left -> right
    Component.onCompleted: world.state = "reanchored_right"

    // Timer to update the state of boat in repeatedly
    Timer {
        interval: worldTime
        running: true
        repeat: true
        onTriggered: {
            if(boat.x == 0) world.state = "reanchored_right" // left -> right
            else world.state = "reanchored_left" // right -> left
        }
    }

    // ParallelAnimation to process for flying of 2 birds
    ParallelAnimation {
        running: true
        loops: Animation.Infinite

        // Apply PathAnimation to decide the flying direction for first Bird
        PathAnimation {
            id: pathAnim
            duration: worldTime
            target: bird
            path: Path {
                startX: world.width; startY: world.height * 0.5
                PathCurve { x: world.width * 0.7; y: world.height * 0.4 }
                PathCurve { x: world.width * 0.5; y: world.height * 0.3 }
                PathCurve { x: world.width * 0.3; y: world.height * 0.5 }
                PathCurve { x: world.width * 0.1; y: world.height * 0.2 }
                PathCurve { x: world.width * 0.0; y: world.height * 0.4 }
            }
        }

        // Apply PathAnimation to decide the flying direction for second Bird
        PathAnimation {
            id: pathAnim2
            duration: worldTime
            target: bird2
            path: Path {
                startX: world.width * 0.9; startY: world.height * 0.55
                PathCurve { x: world.width * 0.75; y: world.height * 0.45 }
                PathCurve { x: world.width * 0.55; y: world.height * 0.35 }
                PathCurve { x: world.width * 0.35; y: world.height * 0.55 }
                PathCurve { x: world.width * 0.15; y: world.height * 0.25 }
                PathCurve { x: world.width * 0.00; y: world.height * 0.45 }
            }
        }
    }
}
