import QtQuick 2.0

Item {
    id: root
    z: -1

    Image {
        id: star
        source: "star.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit

        // Rotate the star
        transform: Rotation {
            origin.x: star.width/2
            origin.y: star.height/2
            axis { x:0; y:1; z:0 }

            // Apply NumberAnimation when the star is rotated
            NumberAnimation on angle {
                from: 0; to: 360
                loops: Animation.Infinite
                duration: 1000
                running: true
            }
        }
    }

    // SequentialAnimation to destroy the star
    SequentialAnimation {
        id: stopStar
        running: false

        // Apply NumberAnimation on opacity to disappear the star
        NumberAnimation {
            target: star
            property: "opacity"
            from: 1; to: 0
            duration: 250
        }

        // Apply ScriptAction to execute script during Animation
        ScriptAction {
            script: root.destroy()
        }
    }

    // The function to start the Animation to destroy the star
    function remove() {
        stopStar.start()
    }
}
