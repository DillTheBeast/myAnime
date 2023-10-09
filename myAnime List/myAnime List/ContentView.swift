import SwiftUI

struct ContentView: View {
    @State private var watchedScene: Bool = false
    @State private var wantScene: Bool = false
    @State private var middleScene: Bool = false
    @State private var addReleaseScene: Bool = false
    @State private var addWatchedScene: Bool = false
    @State private var addWantScene: Bool = false
    @State private var addMiddleScene: Bool = false
    @State private var deleteWatchedScene: Bool = false
    @State private var deleteWantScene: Bool = false
    @State private var deleteMiddleScene: Bool = false
    var scenes: [Bool] {
        [watchedScene, wantScene, middleScene, addReleaseScene, addWatchedScene, addWantScene, addMiddleScene, deleteWatchedScene, deleteWantScene, deleteMiddleScene]
    }

    
    @AppStorage("Watched") var WatchedData: Data = Data()
    @AppStorage("Want") var WantData: Data = Data()
    @AppStorage("Middle") var MiddleData: Data = Data()
    
    @State private var Watched: [String] = []
    @State private var Want: [String] = []
    @State private var Middle: [String] = []
    
    @State private var WatchedSelect: String = ""
    @State private var WantSelect: String = ""
    @State private var MiddleSelect: String = ""
    
    @State private var place: Int = 0

    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Button("Add an Anime you have Watched") {
                    watchedScene.toggle()
                    for i in scenes {
                        if scenes[i] != watchedScene {
                            
                        }
                    }
                    wantScene = false
                    middleScene = false
                    addReleaseScene = false
                    addWantScene = false
                    addWatchedScene = false
                    addMiddleScene = false
                    deleteWantScene = false
                    deleteWatchedScene = false
                    deleteMiddleScene = false
                }
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
                Button("Add an Anime your Watching") {
                    middleScene.toggle()
                    wantScene = false
                    watchedScene = false
                    addReleaseScene = false
                    addWantScene = false
                    addWatchedScene = false
                    addMiddleScene = false
                    deleteWantScene = false
                    deleteWatchedScene = false
                    deleteMiddleScene = false
                }
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
                Button("Add an Anime you want to Watch") {
                    wantScene.toggle()
                    middleScene = false
                    watchedScene = false
                    addReleaseScene = false
                    addWantScene = false
                    addWatchedScene = false
                    addMiddleScene = false
                    deleteWantScene = false
                    deleteWatchedScene = false
                    deleteMiddleScene = false
                }
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

