# Meal Categories

### Requirement
The application allows users to browse recipes, their instructions, and ingredients.

### User cases
* A user browsing the list of recipes.
* A user reviewing the recipe details when clicking on a recipe.
* A user going over reviewed recipes when turning off the network.

### Screenshots
| Meal list | Meal details | Meal list and details (landscape screen)|
|----------|----------|----------|
|<img src="https://user-images.githubusercontent.com/118146780/281936309-20eee05f-ea18-47e0-ab6c-bfe92f653784.png" width="150" height="300" alt="Screenshot_20231105_054706"> | <img src="https://user-images.githubusercontent.com/118146780/281936338-c8c54a12-044c-498b-8cd6-7ebd9dd8d25c.png" width="150" height="300" alt="Screenshot_20231105_054706"> | <img src="https://user-images.githubusercontent.com/118146780/281936329-15af9bdf-57ef-4461-859a-bfabca7c2620.png" width="300" height="150" alt="Screenshot_20231105_054706"> <img src="https://user-images.githubusercontent.com/118146780/281936336-c94203f1-2fd6-4dfd-bf70-e8c105b570b8.png" width="300" height="150" alt="Screenshot_20231105_054706">|

### Main flow
![Main Flow](https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/bfeb3b7e-5272-4ec5-9117-cb189826e3e1)
* Upon network activation, the app fetches data from an external service and saves meal details to local storage for a seamless user experience.
* When offline, the app displays recipes saved locally, ensuring uninterrupted access for users without an active network connection.

### Sequence diagrams
**1. Upon network activation, users can access meal details**
![Screenshot 2023-11-09 at 4 59 42 PM](https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/16c1836c-46a5-4ca9-adaf-dbc02207f4a7)


**2. Upon network deactivation, users can access meal details**
<img width="838" alt="Screenshot 2023-11-09 at 8 13 46 PM" src="https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/0a04314f-2b17-42cf-8d62-72cb843755ed">

### Non-functional requirements
* Support offline access to the recipes.
* Code structure support for enhancement, maintenance, and high scalability.
* Easy to test, high performance, and highly code reusable.
* Perform consistently in the system, and support error-handling.
* Support friendly user interface, take basic app design principles into account (load to refresh, simple animation).

### Enhancement
* Enable offline access to recipe images and ingredients: *Even without an internet connection, the app downloads images and ingredient details for offline access.*
* Stay seamlessly connected with automatic online/offline data access: *The app adapts to the network status effortlessly, the user can access the data online or offline automatically.*
* Stay in the loop with recipe updates: *Users receive friendly notifications and inform them whenever a recipe is updated on the server.*
* Customize your reading experience: *Users can customize the app's font size to suit their preferences.*

### Technologies applied: 
* Platform: iOS
* Language: SwiftUI
* Programming paradigm:  Object-Oriented Programming (OOP), Protocol-Oriented Programming (POP), Functional Programming (FP), SOLID
* Design pattern: MVVM, Singleton, Factory, Dependency Injection, Observer
* Web services/Notification: RESTful, JSON, Async/Await, Offline Notification
* Multi threads: Task, DispatchQueue
* Storage: Core Data
* Testing: XCTest, XCUITest, integration test, performance test
* Code management: Git, Github
* SDK/Tools: XCode, Postman
