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

<img src="https://user-images.githubusercontent.com/15052850/86951580-2aaf1480-c16b-11ea-9657-b474cb6612e3.jpeg" width="150">

```swift
//MARK: CHANNELS
extension CCQueryEngine {
    .
    .
    .
    func userChannel(id: String?) -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.document("\(env)\(CCQueryPath.channelsData.rawValue)/\(id ?? "")")
    }
    .
    .
    .
}
```

```swift
func fetchData<T: Codable>(query: Query, completion: @escaping (Result<[T], Error>) -> ()){
        query.getDocuments { (documents, error) in
            guard error == nil, let data = documents else {
                completion(.failure(CCError.firebaseFailure))
                return
            }
            do {
                let output = try data.documents.compactMap({ try $0.data(as: T.self) })
                completion(.success(output))
            } catch {
                completion(.failure(CCError.networkEngineFailure))
            }
        }
    }
}
```

- Twilio Video SDK

<img src="https://user-images.githubusercontent.com/15052850/86951835-7eb9f900-c16b-11ea-961b-dd39328e363f.png" width="150">

```swift
extension CCCallScreenVM : CCTwilioService {
    
    ///Joins the Twilio Video Channel
    func joinChannel(result: ((Result<Room, CCError>)->())?){
        guard let channelID = channelData?.id else { result?(.failure(.twilioCredentialsError)); return }
        refreshAccessToken { [weak self](tokenResult) in
            switch tokenResult {
            case .success(let token):
                let connectOptions = ConnectOptions(token: token.token ?? "") { (connectOptionsBuilder) in
                    connectOptionsBuilder.roomName = channelID
                    if let audioTrack = self?.localAudioTrack {
                        connectOptionsBuilder.audioTracks   = [ audioTrack ]
                    }
                    if let dataTrack = self?.localDataTrack {
                        connectOptionsBuilder.dataTracks    = [ dataTrack ]
                    }
                    if let videoTrack = self?.localVideoTrack {
                        connectOptionsBuilder.videoTracks   = [ videoTrack ]
                    }
                }
                self?.room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
            case .failure(let error):
                result?(.failure(error))
            }
        }
    }
}
```

- Branch.io Analytics

<img src="https://user-images.githubusercontent.com/15052850/86951607-2e429b80-c16b-11ea-86b2-4af5927762c5.png" width="150">

```swift

```

- Firebase Deeplinking

<img src="https://user-images.githubusercontent.com/15052850/86951939-a90bb680-c16b-11ea-8d28-4e2c88cd2138.png" width="150">

```swift
protocol CCDynamicLinkEngine {}

extension CCDynamicLinkEngine {
    
    func generateShareLink<T: CCContainsID>(input: T?, completion: @escaping (Result<String?, CCError>)->()){
        let lp = linkProperties()
        lp.addControlParam("id", withValue: input?.id ?? "")
        lp.addControlParam("isGroup", withValue: input is CCChannel ? "false" : "true")
        universalObject().getShortUrl(with: lp) { (string, error) in
            guard error == nil else { completion(.failure(.branchLinkError)); return }
            completion(.success(string))
        }
    }
}
```

---------------
Muhammad Usman Nazir
