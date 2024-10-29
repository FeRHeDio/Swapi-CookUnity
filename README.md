# Swapi-CookUnity
## CookUnity Code Challenge by Fernando Putallaz
## ferhedio@gmail.com

## Requirements

No special requirements.
- Xcode 15.4 (should work on Xcode 16)
- iOS 17

## Installation

The Project doesn't require any external library.

1. Clone the project
2. Open Swapi-CookUnity.xcodeproj
3. Run on Device or Simulator

## Comments

## UI

I decided to leave the UI as simple and basic as posible, and focus the time in the architectural part of the challenge and with a strong base build a better UI over it.

The UI is composed of 3 different views: 

- `CharacterListView` -> Here resides the ScrollView to render each of the character cards feeded by a `CharactersViewModel`.

- `CharacterCardView` is a simple reusable View that renders the data shown and gives shape to the card.

- `CharacterDetailView` is the detail view which is displayed when you tap on each individual card.


## Services

### PeopleLoaderProtocol

This protocol is used to decouple the ViewModel from the different sources that the data of Characters may come from.
It requires the implementation of `getPeople()` func, `resetCollection` and `hasMorePages` for pagination which is defaulted with an extension to `true`

### DataLoader

This class is in charge of doing the logic between different implementations of the Protocol. For example in the App depending on a fake `Reachability` this loader decides to use `ApiLoader` or `DBLoader`, or any loader that conforms to `PeopleLoaderProtocol`. It can be another URL or another implementation of the same one, on memory or any implemented Database.

### ApiLoader

This is the concrete implementation of the Api. In this case I choose to use native `URLSession` which is solid enough and it can be easily tested.
The implementation is used using Async/Await to deal with the Asynchronous nature of network calls.

### DBLoader

An example of a non existent Database concrete implementation to use, for example, when the use is offline.

## Models 

### People

Since the data coming from the API is very simple I decided to leave it as is. Of course in real world I'll use a RemoteModel to match the api and an internal one to feed my views. In this way if the API changes we only need to change the remote model and keep the internals untouched.

## ViewModels

### CharactersViewModel

This ViewModel is in charge of talking with any concrete implementation of any `PeopleLoaderProtocol`. It receives and manages the State of the people collection which is consumed by the view.

## App Entry Point - Swapi_CookUnityApp: App - Dependeny Injection

Here takes place the Composition of the App. As you can see I'm using Dependeny Injection and injecting the different dependencies at this point. I decided to inject the `DataLoader` since is the one in charge of switching between different concrete implementations of the loader in the case things go wrong but we can use `ApiLoader` `DBLoader` or anything else that conforms to the protocol.

## Unit Tests

### Swapi_CookUnityTests 

Hit CMD+U and see the test pass.

This is a simple but working example of a test strtategy that test specifically the `ApiLoader`

Here I used URLProtocol to intercept network request with `URLSessionMock` and I mimick the response of the call with `makePeopleResponse`.

Then I make some assertions to know if things go well. Try changing any expectation and you can see.

In this tests I use `makeSUT` to protect the tests from future changes and also use another factory method to inject the response in this tests and of course in future ones.

This is just a simple example and many more robust test can be made with this base.

## Final thoughts.

In this way I tried to use SOLID Principles in many places, tried to apply the Separation of Concerns to not couple responsibilites acrross different modules and in this way we can extend the app in many different ways, have a testable and a clear base where we can build upon.




 

