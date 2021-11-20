# Pokedex 

![Screenshot](https://github.com/binishmaharjan/pokedex/blob/master/images/screeshot.png)

A demo pokedex app built for iOS. This is just practice app for MVVM+Clean Architecture in iOS. 

## Features
- Show list of all Pokemon, with detail 
- Show list of all available Pokemon Moves
- Show list of all available Items

## Requirements
- iOS 14.0
- Xcode 12.3

## How To Run
- Clone the repo
- Navigate to root folder > App > Pokedex.xcodeproj

## Open API
Pokedex using the [PokeAPI](https://pokeapi.co/) for constructing RESTful API.
PokeAPI provides a RESTful API interface to highly detailed objects built from thousands of lines of data related to Pokémon.

## Dependecy Manager
#### Swift Package Manager
- Incase of error
  - File->Swift Packages->Resolve Package Versions in Xcode

## Dependencies
| Dependency | Usages |
| --- | --- |
|[APIKit](https://github.com/ishkawa/APIKit)| Networking |
|[DIKit](https://github.com/ishkawa/DIKit)| Dependency Injection |
|[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)| Saving in Keychain |
|[Nuke](https://github.com/kean/Nuke)| Image download and caching |
|[Reactive Swift](https://github.com/ReactiveCocoa/ReactiveSwift)| Reactive Framework |
|[Reactive Cocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)| Reactive Framework |

## App Architecture(MVVM+Clean Architecture)
<img src="https://github.com/binishmaharjan/pokedex/blob/master/images/clean-architecture.png" width="413" height="320" />

### Clean Architecture

In Clean Architecture, we have different layers. The main rule is not to have dependencies from inner layers to outers layers

### Dependency Direction
`Presentation Layer -> Domain Layer <- Data Repositories Layer`

#### - Domain Layer (Business logic) = Entities + Use Cases + Repositories Interfaces
The inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models), Use Cases, and Repository Interfaces. This layer could be potentially reused within different projects. Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable)

#### - Presentation Layer (MVVM) = ViewModels(Presenters) + Views(UI)
This layer contains UI (UIViewControllers or SwiftUI Views). Views are coordinated by ViewModels (Presenters) which execute one or many Use Cases. Presentation Layer depends only on the Domain Layer.

#### - Data Repositories Layer = Repositories Implementations + API(Network) + Persistence DB
This layer contains Repository Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data (e.g. Decodable conformance) to Domain Models.

### MVVM(Model-View-View Model)

#### - View Controller
It only performs things related to UI — Show/get information. Part of the view layer

#### - View Model
It receives information from VC, handles all this information, and sends it back to VC.

#### - Model
This is only your model, nothing much here. It’s the same model as in MVC. It is used by VM and updates whenever VM sends new updates
