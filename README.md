# Simple Music Player App

This is a simple music player app. This application will display a list of songs, including song titles, singer names, and song album names. Users can start searching for songs by artist or singer name. then the user can play the user-selected song.

## Getting Started
### Installing
   * Follow the instruction to integrate Flutter SDK with your IDE 
   * Clone the project with ssh to your local machine
      - go to the folder where you want to put the project
      - open the terminal
      - type ```git@github.com:artprasetya/simple-music-player-app.git```
   * Open your IDE and select simple-music-player-app folder

### Running
* Just type ```make run```  on your terminal


## Supported Devices
This app is supported on Android with minimum version of Android KitKat (4.4) or API level 19 and above

## Features
* Display a list of songs
* Search for songs by arttist
* Play the selected song

## Requirements to build the app
* [iTunes Search API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api) to provide the list of songs
* Flutter SDK
* [Dio](https://pub.dev/packages/dio) to make HTTP request to iTunes Search API
* [Flutter BLoC](https://pub.dev/packages/flutter_bloc) to manage the state of the app
* [Just Audio](https://pub.dev/packages/just_audio) to play the song
  
## How to build the app
To build the app, you just need to type ```make apk``` on your terminal to build debug version of the app. And if you want to build release version, you can type ```make apk mode=release```.