# Crowd Cast

In the current state of affairs, we often have to attend Video Calls with collgues, friends and families. As the medium of video calls becomoes increasingly popular, we often find ourselves sharing links to video calls which everyone can join in. But sharing links again and again to everyone can be tedious and inefficient. Crowd Cast is a project aimed at adding a layer to this need. 

With Crowd Cast, there is no need to individually share video call links with people anymore. Providing an independant video calling platform, Crowd Cast allows you to create and join video call channels seamlessly. Crowds are groups of people that can be created where each member can access each video call channel within the Crowd. The individual channels you create can be shared and join using generated short deeplinks that provide a swift experience to quickly get started.

Crowd Cast is a side project aimed at showcasing my programming style and some of the technologies that I have worked with over time with Swift in iOS.

The app includes the following programming practices:

- MVVM
```swift
```

- Protocol Oriented Programming

```swift
protocol CCSetsNavbar : CCOpensSettings {}

extension CCSetsNavbar {
    
    /// Sets up navigation bar
    /// - Parameters:
    ///   - navigationBar: View Controller's navigation bar
    ///   - navigationItem: View Controller's navigation controller
    ///   - title: View Controller's title
    ///   - largeTitles: should prefer large titles
    ///   - profileAction: profile button action
    func setupNavBar(navigationBar: UINavigationBar?,navigationItem: UINavigationItem, title: String?, largeTitles: Bool, profileAction: Selector?){
        navigationItem.title                = title
        navigationBar?.prefersLargeTitles   = largeTitles
        let leftButton                      = getLogoButton()
        let profileButton                   = getProfileButton(action: profileAction)
        profileButton.action                = profileAction
        navigationItem.leftBarButtonItem    = leftButton
        navigationItem.setRightBarButtonItems([profileButton], animated: true)
    }
}
```

- Generics

```swift
func request<T: Codable>(endpoint: Endpoint, result: @escaping (Result<T, CCError>)->()){
        var components      = URLComponents()
        components.scheme   = endpoint.scheme
        components.host     = endpoint.host
        components.path     = endpoint.path
        
        guard let url           = components.url else { return }
        var urlRequest          = URLRequest(url: url)
        urlRequest.httpMethod   = endpoint.httpMethod.rawValue
        
        let session     = URLSession(configuration: .default)
        let dataTask    = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, response != nil, let data = data else { return }
            let responseObject  = try! JSONDecoder().decode(T.self, from: data)
            result(.success(responseObject))
        }
        dataTask.resume()
    }
```
- Multithreading

Defining custom Dispatch Queue protocol for ease of use:
```swift
protocol CCDispatchQueue {}

extension CCDispatchQueue {
    
    /// Dispatch Priority Item
    /// - Parameters:
    ///   - type: Async/Sync
    ///   - code: Code Block to run
    /// - Returns: nil
    func dispatchPriorityItem(_ type: DispatchQueue.Attributes, code: @escaping ()->()){
        let queue = DispatchQueue(label: "com.CrowdCast.HighPriority", qos: .utility, attributes: type)
        queue.async(execute: DispatchWorkItem(block: code))
    }
}
```
Implementation:
```swift
extension CCChannelsVM : CCChannelsService, CCDispatchQueue, CCGetIndexPaths {
    
    func fetchFreshData() {
        
        let dg = DispatchGroup()
        
        var fetchedCounts = (0, 0)
        var newMyChannels      = 0
        var newJoinedChannels  = 0
        
        dg.enter()
        dispatchPriorityItem(.concurrent, code: {
            self.getUserChannels(type: .owned) { (result) in
                switch result {
                case .success(let inputData):
                    self.myChannels.clearData()
                    self.myChannels.updateData(input: inputData)
                    fetchedCounts = (inputData.data.count, fetchedCounts.1)
                    newMyChannels = inputData.data.count
                    dg.leave()
                case .failure(let error):
                    prints(error)
                    dg.leave()
                }
            }
        })
        
        dg.enter()
        dispatchPriorityItem(.concurrent, code: {
            self.getUserChannels(type: .joined) { (result) in
                switch result {
                case .success(let inputData):
                    self.joinedChannels.clearData()
                    self.joinedChannels.updateData(input: inputData)
                    fetchedCounts = (fetchedCounts.0, inputData.data.count)
                    newJoinedChannels = inputData.data.count
                    dg.leave()
                case .failure(let error):
                    prints(error)
                    dg.leave()
                }
            }
        })
        
        dg.notify(queue: .global()) { [weak self] in
            self?.publishChannelUpdates(action: CCChannelsVC.refresh ? .refresh : .insert, newCreatedChannels: newMyChannels, newJoinedChannels: newJoinedChannels)
            CCChannelsVC.refresh = false
        }
    }
```

- Swift Result Types

```swift
```

- Swift Combine

```swift
```

- Swift Enums

```swift
enum CardHeaderAction {
    case newChannel, newGroup, joinChannel, joinGroup, viewAll, pinnedChannels
}
```

- Swift Extensions

```swift

```

Frameworks used:

- Firestore
```swift
```

- Twilio Video SDK
```swift

```

- Branch.io Analytics
```swift
```

- Firebase Deeplinking
```swift
```

- Kingfisher
```swift
```

---------------
Muhammad Usman Nazir
