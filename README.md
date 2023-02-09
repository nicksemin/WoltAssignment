# Description
This is an assignment for Wolt Summer Internship 2023 (mobile/iOS). The project is completed by Nikolai Semin.

## Supported OS:
iOS 16.0 and higher. However, no APIs specific to iOS 16 were used and the project can be built with iOS 14

## Dependencies:
No Swift Packages or other external dependencies were used. Standard iOS SDK and Xcode tools are enough to build the app.

# Instructions
## Simulator

To run the app on simulator, follow these steps:

1. Select a simulator target in Xcode and run the project 
2. Allow use of geolocation for the app
3. Note that initial location will be set to Cupertino, and you will have to change it manually to corrdinates in Helsinki ([see 'Edge Cases'](#edge-cases))
4. To change the location go to Simulator menubar -> Features -> Location -> Custom location

## Real device 

To run the app on simulator, follow these steps:

1. Enable developer mode on your device
2. Select your device as a target in Xcode and upload the app to your device
3. Add me as a trusted developer (iPhone Settings -> General -> Device Management and "trust" me as a developer)
4. Allow use of geolocation for the app
5. Initial launch and fetching data may take some time
6. Move around the city and see how the list changes (commuter trains are a nice way to test it :D) 


# Reflections:
## Caching
Adding last loaded restaurants to cache would be great, as well as the last location.

## Startup time
While Wolt's real app is really swift to start, my app takes a few seconds to load all the venues. Better handling of network request could potentially imporve the situation. Moreover, the JSON to decode is big and that might have its influence too. Speaking about UI, Skeleton screen could be more firendly than activity indicator.

## Edge cases
If there was slightly more time, I would ideally propagate an alert when there is no network or geolocation is not available. Additionally, there are cases when no restautants nearby are found (that happens at initial Simulator startup); therefore, a view to communicate that would be a good improvement.

## The Typo
Yep, I made a typo initially and used 'restuarants' in the project name (and it is the bundle name now too). I hope that it can be forgiven :)

# Comment (09.02)
I have noticed that the my Response struct had some elemnts of the response hardcoded (a very bad thing indeed). I have changed it and here is the updated version, that should be much more flexible
