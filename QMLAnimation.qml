import QtQuick 2.3

Item {
    id: world
    width: 1400
    height: 700

    property int worldTime: 10000 // 10 seconds

    // This is the sky
    Rectangle {
        id: sky
        anchors.fill: parent
        color: "light blue"
        z: -1
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

    // This is the sun
    Rectangle {
        id: sun
        width: world.width * 0.05
        height: width
        x: 0
        y: world.height * 0.3
        radius: width / 2
        color: "yellow"

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
    }

    // This is the clouds group
    Cloud {
        id: cloud1; mWorldTime: worldTime; x: 100; y: 100; width: 160; height: 100; z: 1
    }
    Cloud {
        id: cloud2; mWorldTime: worldTime; x: 200; y: 300; width: 240; height: 100; z: -1
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

    // Animation to change the sun's color
    PropertyAnimation {
        target: sun
        loops: Animation.Infinite
        property: "color"
        from: "red"
        to: "yellow"
        duration: worldTime
        running: true
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
}
