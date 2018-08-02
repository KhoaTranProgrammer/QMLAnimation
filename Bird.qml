import QtQuick 2.0

Item {
    id: root

    // This is left wing
    Image {
        id: leftWing
        source: "wing.png"
        anchors {
            left: parent.left
            right: parent.horizontalCenter
        }
        fillMode: Image.PreserveAspectFit

        // Rotation to decides the origin
        transform: Rotation {
            id: rotLeft
        }

        // SequentialAnimation to process clap the wing
        SequentialAnimation {
            running: true
            loops: Animation.Infinite

            // Change the origin while animating
            PropertyAction { target: rotLeft; property: "origin.x"; value: leftWing.width }
            PropertyAction { target: rotLeft; property: "origin.y"; value: leftWing.height }

            // NumberAnimation to clap the wing up&down
            NumberAnimation {
                target: rotLeft
                property: "angle"
                from: 20; to: 35
                duration: 500
            }
            NumberAnimation {
                target: rotLeft
                property: "angle"
                from: 35; to: 20
                duration: 500
            }
        }
    }

    // This is right wing
    Image {
        id: rightWing
        source: "wing.png"
        anchors {
            left: parent.horizontalCenter
            right: parent.right
        }
        fillMode: Image.PreserveAspectFit

        // Rotation to decides the origin
        transform: Rotation {
            id: rotRight
        }

        // SequentialAnimation to process clap the wing
        SequentialAnimation {
            running: true
            loops: Animation.Infinite

            // Change the origin while animating
            PropertyAction { target: rotRight; property: "origin.x"; value: leftWing.right }
            PropertyAction { target: rotRight; property: "origin.y"; value: leftWing.height }

            // NumberAnimation to clap the wing up&down
            NumberAnimation {
                target: rotRight
                property: "angle"
                from: -20; to: -35
                duration: 500
            }
            NumberAnimation {
                target: rotRight
                property: "angle"
                from: -35; to: -20
                duration: 500
            }
        }
    }
}
