# Pokedex 

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

## App Architecture
MVVM+Clean Architecture
Dependency Direction
Presentation Layer -> Domain Layer <- Data Repositories Layer

Presentation Layer (MVVM) = ViewModels(Presenters) + Views(UI)
Domain Layer = Entities + Use Cases + Repositories Interfaces
Data Repositories Layer = Repositories Implementations + API(Network) + Persistence DB
