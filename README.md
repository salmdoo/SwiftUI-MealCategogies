# Meal Categories

### Requirement
The application provides users with a seamless experience, empowering them to effortlessly explore a diverse array of recipes. It presents comprehensive details, including instructions and a comprehensive list of ingredients, enhancing the user's culinary journey with a wealth of information and inspiration.

### User cases
* A user browsing the list of meals.
* A user reviewing the recipe details when clicking on a meal.
* A user going over reviewed recipes in offline mode.

### Screenshots
**Display in vertical orientation**
| Meal list | Meal details |
|----------|----------|
|<kbd><img src="https://user-images.githubusercontent.com/118146780/282129797-c6303cf1-856b-4138-aa58-3cfbe06376d7.png"></kbd> | <kbd><img src="https://user-images.githubusercontent.com/118146780/282130027-69a0faea-25c3-490d-98ca-33cb1443c629.png"></kbd> | 

**Display in horizontal orientation.**
| Meal list | Meal details |
|----------|----------|
|<kbd><img src="https://user-images.githubusercontent.com/118146780/282130599-e66da311-6772-48e9-b2c6-963bb051f109.png"></kbd> | <kbd><img src="https://user-images.githubusercontent.com/118146780/282130796-e51eaa2c-3c94-4f2c-8558-3aee595ab4bc.png"></kbd> |

### Main flow
![Main Flow](https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/bfeb3b7e-5272-4ec5-9117-cb189826e3e1)
* Upon network activation, the app fetches data from an external service and saves meal details to local storage for a seamless user experience.
* When offline, the app displays recipes saved locally, ensuring uninterrupted access for users without an active network connection.

### High level architechture
![High level architecture](https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/9c66d4a4-9f7a-40e4-b4f6-fec1ed97261c)

Apply *Vertical Slice Architecture* to build the application. Componentization distinguishes meal and meal details, allowing independent modifications

* **Model:** Pure structs define object attributes, with the option to implement the DecodeDataProtocol for decoding data when necessary.
* **View:** Employs a ViewModel, injecting a suitable protocol to retrieve and present essential data on the screen.
* **ViewModel:** Receives a FetchProtocol from the View, utilizes the fetchData() method to obtain results, processes the outcomes, and publishes the final result to the views.
* **DataFetcher:** Defines logic related to data retrieval, implementing the FetchProtocol to retrieve data from various sources, including external systems, RESTful APIs, or local storage

  
### System design overview
![Screenshot 2023-11-10 at 10 47 46 AM](https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/c776f757-9588-4bd1-8696-e6201c2751cc)

### Sequence diagrams
**1. Upon network activation, users can access meal details**
![Screenshot 2023-11-10 at 10 49 33 AM](https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/e9a55f55-10e6-4524-95c1-5709cbc6987c)

**2. Upon network deactivation, users can access meal details**
![Screenshot 2023-11-10 at 10 50 38 AM](https://github.com/salmdoo/SwiftUI-MealCategogies/assets/118146780/9b0d3e85-6d21-49e5-8aa6-bcaf2993499b)

### Non-functional requirements
* Optimized for Efficiency and Scalability: *Utilizing Vertical Slice Architecture, generic classes, and adhering to POP principles ensures a robust, easily expandable, and test-friendly code structure.*
* Highly code reusable, performs consistently in the system: *Employing POP and MVVM architecture ensures maximum code reuse and consistent performance. Modern async/await pattern manages asynchronous API requests seamlessly.* 
* Proactive Error Handling: *Enhance user experience by promptly alerting users of any application failures through intuitive error messages.*
* Support friendly user interface: *The app includes pull-to-refresh for easy meal reloading and adapts dynamically to device orientation.*
* Access app in offline mode: *Core Data enables robust data persistency for offline recipe review while using the NWPathMonitor to adjust meal fetching based on device network status.*

### Enhancement
* Enable offline access to recipe images and ingredients: *Even without an internet connection, the app downloads images and ingredient details for offline access.*
* Stay seamlessly connected with automatic online/offline data access: *The app adapts to the network status effortlessly, the user can access the data online or offline automatically.*
* Stay in the loop with recipe updates: *Users receive friendly notifications and inform them whenever a recipe is updated on the server.*
* Customize your reading experience: *Users can customize the app's font size to suit their preferences.*
* Support multiple platforms: *User can access the application on iPad, watchOS, or macOS.*

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
