# Take Home Test from LetsGetChecked
## Task

### Create an app that does the following:
The app should make an api request using the following weather api.
Details can be found here: https://www.weatherapi.com/
There are links on the home page for “Sign Up” & “View Docs”.
You will need to sign up for a free account to retrieve an api key - once retrieved you can use the api key to make various weather related requests.
An example of some of the request endpoints:
  • https://api.weatherapi.com/v1/current.json?Key={api-key}&q=Dublin
    Http Get request which returns current weather related data in Json format for a specified query location.
  • https://api.weatherapi.com/v1/forecast.json?Key={api-key}&q=Dublin&dt={yyyy-MM-dd} Http Get request which returns weather forecast data in Json format for a specified query location and for a specified date.
  
The weatherapi service provides various other api endpoints and various other request parameters. The Swagger link below can be used to investigate the various available weather api. https://app.swaggerhub.com/apis-docs/WeatherAPI.com/WeatherAPI/1.0.2#/

#### Description

The app should allow the user to enter a location. Once entered the user can hit a search button which makes the “Current” Weather api call. The query should be configured to return Json (not xml). Parse the response to display the weather for the current location.

Display at least 3 elements of the above data on an action sheet.
It should have a cancel button to dismiss the view so that the user can interact with the search box again.

Every time a search is made with the api, store the query key word in a table below the search box to allow the user to tap on them to search for the weather details again.

It should also meet the following requirements:
- A universal app.
- Use UIKit with auto layout (not SwiftUI)
- Written in Swift.
- Include unit tests (at least one) with a test target included in the workspace.
    
- Available on a git repo of your choice for me to access ( eg. Github, Bitbucket ).
- Set up the project to use localisation. Add one translation for one other language.
- Create a networking layer to handle API requests (success and failures) in a generic
way.
- Support iOS 15 minimum.
- If you use an external dependency please include an explanation of what the library
does and why you choose it.
- Please provide a write up on any architecture choices you made in the app.

This is the minimum required. Have fun and feel free to impress.

## Implemented Key Features
[X] Search field to enter a location<br>
[X] Search button to call the API<br>
[X] Weather API Integration<br>
[X] Weather API with localization<br>
[X] Google Place API Integration for autocomplete<br>
[X] Added APIKeys.json to Resource Tags 
[X] Display action sheet with weather data<br>
[X] Store query key word in a table <br>
[X] Use UserDefaults to store weather locations 
[X] Tap on the searched weather locations to get data from API <br>
[X] Swipe left to delete row from table<br>
[X] Universal app<br>
[X] Swift and UIKit with auto layout<br>
[X] Unit tests<br>
[X] Localized strings (English and Portuguese)<br>
[X] Networking layer using Combine Framework<br>
[X] Displaying Error in case some Weather API or Google Place API error<br>
[X] Support iOS 15 minimum<br>
[X] Documentation<br>

## Important observations
-> API Keys cannot be stored in the code or even in the info.plist. This could lead to a leak, and the API Keys will be exposed. To prevent, and mange properly the API Keys we should use some service to store the API Keys outside the app, and should be donwloaded as some kind of resource after the app is installed.<br>
-> Implemented the Google Place API to have the autocomplete in the location input.<br>

## Clean Architecture
My approach is following the separations of concerns, dependency inversion, and keeping the core logic independent of external frameworks. Each layer should not depend on any other layer. This way the project is robust, maintainable, flexible, and scalable codebase. Also, this way the implemented features are easier to test and it's easier to implement new features. 

### Thanks for reviewing my challenge, I am open to any suggestion and always open to improve! :)


