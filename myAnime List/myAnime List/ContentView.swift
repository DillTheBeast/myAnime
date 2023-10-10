import SwiftUI

struct ContentView: View {
    @State private var watchedScene: Bool = false
    @State private var wantScene: Bool = false
    @State private var middleScene: Bool = false
    @State private var releaseScene: Bool = false
    @State private var seasonsScene: Bool = false
    @State private var addReleaseScene: Bool = false
    @State private var addWatchedScene: Bool = false
    @State private var addWantScene: Bool = false
    @State private var addMiddleScene: Bool = false
    @State private var deleteWatchedScene: Bool = false
    @State private var deleteWantScene: Bool = false
    @State private var deleteMiddleScene: Bool = false
    
    @AppStorage("Watched") var WatchedData: Data = Data()
    @AppStorage("Want") var WantData: Data = Data()
    @AppStorage("Middle") var MiddleData: Data = Data()
    
    @State private var newRelease: [String] = []
    @State private var seasons: [String] = []
    @State private var Watched: [String] = []
    @State private var Want: [String] = []
    @State private var Middle: [String] = []
    
    @State private var WatchedSelect: String = ""
    @State private var MiddleSelect: String = ""
    
    @State private var place: Int = 0
    
    init() {
            if let savedWatched = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Watched") ?? Data()) {
                _Watched = State(initialValue: savedWatched)
            }
            if let savedWant = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Want") ?? Data()) {
                _Want = State(initialValue: savedWant)
            }
            if let savedMiddle = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Middle") ?? Data()) {
                _Middle = State(initialValue: savedMiddle)
            }
        }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if watchedScene {
                    watched(watchedScene: $watchedScene, releaseScene: $releaseScene, watched: $Watched, watchedSelect: $WatchedSelect)
                } else if middleScene {
                    middle(middleScene: $middleScene, seasonsScene: $seasonsScene, middle: $Middle, middleSelect: $MiddleSelect)
                } else if wantScene {
                    want(wantScene: $wantScene, want: $Want)
                } else if addWatchedScene {
                    addWatched(addWatchedScene: $addWatchedScene, watched: $Watched, newRelease: $newRelease)
                } else if addWantScene {
                    addWant(addWantScene: $addWantScene, want: $Want)
                } else if addMiddleScene {
                    addMiddle(addMiddleScene: $addMiddleScene, middle: $Middle, seasons: $seasons)
                } else {
                    Button("View an Anime you have Watched") {
                        resetScenes()
                        watchedScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("View an Anime your Watching") {
                        resetScenes()
                        middleScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("View an Anime you want to Watch") {
                        resetScenes()
                        wantScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("Add an Anime you have Watched") {
                        resetScenes()
                        addWatchedScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("Add an Anime your Watching") {
                        resetScenes()
                        addMiddleScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("Add an Anime you want to Watch") {
                        resetScenes()
                        addWantScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("Delete an Anime you have Watched") {
                        resetScenes()
                        deleteWatchedScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("Delete an Anime your Watching") {
                        resetScenes()
                        deleteMiddleScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    Button("Delete an Anime you want to Watch") {
                        resetScenes()
                        deleteWantScene = true
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    
    func resetScenes() {
        watchedScene = false
        wantScene = false
        middleScene = false
        releaseScene = false
        seasonsScene = false
        addReleaseScene = false
        addWatchedScene = false
        addWantScene = false
        addMiddleScene = false
        deleteWatchedScene = false
        deleteWantScene = false
        deleteMiddleScene = false
    }
}

struct watched: View {
    @Binding var watchedScene: Bool
    @Binding var releaseScene: Bool
    @Binding var watched: [String]
    
    @Binding var watchedSelect: String
    
    var body: some View {
        VStack() {
            // Contents for your ViewAccount here
            
            List(watched.indices, id: \.self) { index in
                Button(action: {
                    watchedSelect = watched[index]
                    releaseScene = true  // Toggle to show the ViewInfo scene
                    watchedScene = false  // Close the ViewAccount scene
                }) {
                    Text(watched[index])
                        .foregroundColor(.white)  // set the text color to white
                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                        .border(Color.black)
                        .background(Color.black)  // set the row background to black
                }
            }
            .listStyle(PlainListStyle())  // Removes default list styling
            .background(Color.black)  // set the list background to black
            
            Button("Go Back") {
                watchedScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make the VStack occupy the entire space
        .background(Color.black)
    }
}

struct want: View {
    @Binding var wantScene: Bool
    @Binding var want: [String]
    
    var body: some View {
        VStack() {
            // Contents for your ViewAccount here
            
            List(want.indices, id: \.self) { index in
//                Text(action: {
//                    wantSelect = want[index]
//                    //viewInfoScene = true  // Toggle to show the ViewInfo scene
//                    wantScene = false  // Close the ViewAccount scene
//                }) {
                    Text(want[index])
                        .foregroundColor(.white)  // set the text color to white
                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                        .border(Color.black)
                        .background(Color.black)  // set the row background to black
                }
            //}
            .listStyle(PlainListStyle())  // Removes default list styling
            .background(Color.black)  // set the list background to black
            
            Button("Go Back") {
                wantScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make the VStack occupy the entire space
        .background(Color.black)
    }
}

struct middle: View {
    @Binding var middleScene: Bool
    @Binding var seasonsScene: Bool
    @Binding var middle: [String]
    
    @Binding var middleSelect: String
    
    var body: some View {
        VStack() {
            // Contents for your ViewAccount here
            
            List(middle.indices, id: \.self) { index in
                Button(action: {
                    middleSelect = middle[index]
                    seasonsScene = true  // Toggle to show the ViewInfo scene
                    middleScene = false  // Close the ViewAccount scene
                }) {
                    Text(middle[index])
                        .foregroundColor(.white)  // set the text color to white
                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                        .border(Color.black)
                        .background(Color.black)  // set the row background to black
                }
            }
            .listStyle(PlainListStyle())  // Removes default list styling
            .background(Color.black)  // set the list background to black
            
            Button("Go Back") {
                middleScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make the VStack occupy the entire space
        .background(Color.black)
    }
}

struct addWatched: View {
    @Binding var addWatchedScene: Bool
    @Binding var watched: [String]
    @Binding var newRelease: [String]

    @State private var watchedWord: String = ""
    @State private var newReleaseWord: String = ""
    @State private var filloutPopup = false
    @State private var accountPopup = false
    
    var body: some View {
        VStack() {
            Text("Enter a Show")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Show name", text: $watchedWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a new Release Date")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a new Release Date", text: $newReleaseWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                if watchedWord.isEmpty || newReleaseWord.isEmpty {
                    filloutPopup = true
                } else if watched.contains(watchedWord) {
                    accountPopup = true
                } else {
                    watched.append(watchedWord)
                    newRelease.append(newReleaseWord)
                    addWatchedScene.toggle()
                }
            }
            .padding()
            .border(Color.white, width: 1)
            .foregroundColor(.white)
            
            Button("Go Back") {
                addWatchedScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        if filloutPopup || accountPopup {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close popup when background is tapped
                    filloutPopup = false
                    accountPopup = false
                }

            VStack(spacing: 20) {
                if accountPopup {
                    Text("You already have this account")
                } else {
                    Text("You did not fill out all of the requirements")
                }
                Button("Close") {
                    filloutPopup = false
                    accountPopup = false
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .frame(width: 300, height: 200)
            .background(Color.red)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}

struct addWant: View {
    @Binding var addWantScene: Bool
    @Binding var want: [String]

    @State private var wantWord: String = ""
    @State private var filloutPopup = false
    @State private var accountPopup = false
    
    var body: some View {
        VStack() {
            Text("Enter a Show")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Show name", text: $wantWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                if wantWord.isEmpty {
                    filloutPopup = true
                } else if want.contains(wantWord) {
                    accountPopup = true
                } else {
                    want.append(wantWord)
                    addWantScene.toggle()
                }
            }
            .padding()
            .border(Color.white, width: 1)
            .foregroundColor(.white)
            
            Button("Go Back") {
                addWantScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        if filloutPopup || accountPopup {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close popup when background is tapped
                    filloutPopup = false
                    accountPopup = false
                }

            VStack(spacing: 20) {
                if accountPopup {
                    Text("You already have this account")
                } else {
                    Text("You did not fill out all of the requirements")
                }
                Button("Close") {
                    filloutPopup = false
                    accountPopup = false
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .frame(width: 300, height: 200)
            .background(Color.red)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}

struct addMiddle: View {
    @Binding var addMiddleScene: Bool
    @Binding var middle: [String]
    @Binding var seasons: [String]

    @State private var middleWord: String = ""
    @State private var seasonsWord: String = ""
    @State private var filloutPopup = false
    @State private var accountPopup = false
    
    var body: some View {
        VStack() {
            Text("Enter a Show")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Show name", text: $middleWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter the amount of seasons")
                .padding()
                .foregroundColor(.white)
            TextField("Enter the number of seasons", text: $seasonsWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                if middleWord.isEmpty || seasonsWord.isEmpty {
                    filloutPopup = true
                } else if middle.contains(middleWord) {
                    accountPopup = true
                } else {
                    middle.append(middleWord)
                    seasons.append(seasonsWord)
                    addMiddleScene.toggle()
                }
            }
            .padding()
            .border(Color.white, width: 1)
            .foregroundColor(.white)
            
            Button("Go Back") {
                addMiddleScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        if filloutPopup || accountPopup {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close popup when background is tapped
                    filloutPopup = false
                    accountPopup = false
                }

            VStack(spacing: 20) {
                if accountPopup {
                    Text("You already have this account")
                } else {
                    Text("You did not fill out all of the requirements")
                }
                Button("Close") {
                    filloutPopup = false
                    accountPopup = false
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .frame(width: 300, height: 200)
            .background(Color.red)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

