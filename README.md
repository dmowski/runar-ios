# runar-ios

## Installation

For start development, necessary packages should be installed on your local machine.

### Homebrew

It is package manager for MacOS. To install it need to execute the following command in Mac Terminal:

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

After installation process will be completed, you will be abble to instal packages using `brew` comand. 
For more details see [Homebrew](https://treehouse.github.io/installation-guides/mac/homebrew).

### CocoaPods

It is a dependency manager for Swift and Objective-C Cocoa projects. To install it need to execute the following command in Mac Terminal:

`brew install cocoapods`

After installation process will be completed, you will be abble to install Cocoa libraries to your project. To do this you should navigate to the project folder `runar-ios/Runar` in Mac Terminal and execute the following command:

`pod install`

After that (based on the `Podfile` file) necessary files and directories will be automatically generated in the project folder. For more detqails see [CocoaPods](https://cocoapods.org/)

## Project

To open Runar mobile application in XCode you should use **Runar.xcworkspace** (not Runar.xcodeproject). 

### Add urls for debug

Then add two urls (which are below) TO THE END in file **Pods-Runar.debug.xcconfig**  in the folder **Pods**.
Urls:

`API_URL = https:/$()/runar-testing.herokuapp.com/api/v1`

`GENERATOR_API_URL = https:/$()/runar-generator-api.herokuapp.com/api/v1`

### Run the project
