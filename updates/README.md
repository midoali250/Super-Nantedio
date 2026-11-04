# Reusable Android updater

`client/android/src/main/java` contains the reusable optional updater; `client/android/sample` is an Android build example with its own Gradle wrapper. A game supplies its own update manifest and publication location. Integrating and testing notifications, download, signature checks and installation in a real app remains the responsibility of each game.
