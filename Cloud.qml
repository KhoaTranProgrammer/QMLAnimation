import QtQuick 2.0

Item {
    id: root
    property int mWorldTime: 10000 // 10 seconds

    Rectangle {
        id: item1
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: width
        radius: height / 2
        color: "teal"
    }

    Rectangle {
        id: item2
        x:0; y: parent.height * 0.1
        width: parent.width * 0.4
        height: width
        radius: height / 2
        color: "teal"
    }

    Rectangle {
        id: item3
        x: parent.width - parent.width * 0.5; y: parent.height * 0.1
        width: parent.width * 0.5
        height: width
        radius: height / 2
        color: "teal"
    }

    // Animation to change the cloud's color
    SequentialAnimation {
        running: true
        loops: Animation.Infinite

        // Morning
        ColorAnimation {
            targets: [item1, item2, item3]
            property: "color"
            to: "white"
            duration: mWorldTime * 0.3
        }

        // Afternoon
        PauseAnimation { duration: mWorldTime * 0.4 }

        // Night
        ColorAnimation {
            targets: [item1, item2, item3]
            property: "color"
            to: "teal"
            duration: mWorldTime * 0.3
        }
    }
}
