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
        color: "white"
    }

    Rectangle {
        id: item2
        x:0; y: parent.height * 0.1
        width: parent.width * 0.4
        height: width
        radius: height / 2
        color: "white"
    }

    Rectangle {
        id: item3
        x: parent.width - parent.width * 0.5; y: parent.height * 0.1
        width: parent.width * 0.5
        height: width
        radius: height / 2
        color: "white"
    }
}
