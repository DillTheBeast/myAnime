import SwiftUI

struct ContentView: View {
    @State private var watchedScene: Bool = false
    @State private var wantScene: Bool = false
    @State private var middleScene: Bool = false
    @State private var addSelectScene: Bool = false
    @State private var deleteSelectScene: Bool = false
    @State private var addWatchedScene: Bool = false
    @State private var addWantScene: Bool = false
    @State private var addMiddleScene: Bool = false
    
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
    
    
    init() {
            if let WatchedSelect = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Watched") ?? Data()) {
                _Watched = State(initialValue: WatchedSelect)
            }
            if let WantSelect = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Want") ?? Data()) {
                _Want = State(initialValue: WantSelect)
            }
            if let MiddleSelect = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Middle") ?? Data()) {
                _Middle = State(initialValue: MiddleSelect)
            }
        }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                if addAccountScene {
                    AddAccount(addAccountScene: $addAccountScene, accounts: $Account, usernames: $Username, passwords: $Password)
                } else if viewAccountScene {
                    ViewAccount(viewAccountScene: $viewAccountScene, viewInfoScene: $viewInfoScene, accounts: $Account, usernames: $Username, passwords: $Password, accountSelect: $accountSelect, usernameSelect: $usernameSelect, passwordSelect: $passwordSelect)
                } else if viewInfoScene {
                    ViewInfo(viewInfoScene: $viewInfoScene, accountSelect: $accountSelect, usernameSelect: $usernameSelect, passwordSelect: $passwordSelect)
                } else if deleteAccountScene {
                    deleteAccount(accounts: $Account, usernames: $Username, passwords: $Password, deleteAccountScene: $deleteAccountScene)
                } else if editAccountScene {
                    EditAccount(accounts: $Account, usernames: $Username, passwords: $Password, accountSelect: $accountSelect, usernameSelect: $usernameSelect, passwordSelect: $passwordSelect, place: $place, editAccountScene: $editAccountScene, editInfoScene: $editInfoScene)
                } else if editInfoScene {
                    EditInfo(accounts: $Account, usernames: $Username, passwords: $Password, accountSelect: $accountSelect, usernameSelect: $usernameSelect, passwordSelect: $passwordSelect, place: $place, editInfoScene: $editInfoScene)
                } else {
                    Button("Add an Anime") {
                        addAccountScene.toggle()
                        viewAccountScene = false
                        viewInfoScene = false
                        deleteAccountScene = false
                        editAccountScene = false
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)

                    Button("View your watched Anime") {
                        viewAccountScene.toggle()
                        addAccountScene = false
                        viewInfoScene = false
                        deleteAccountScene = false
                        editAccountScene = false
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    
                    Button("View your want to watch Anime") {
                        viewAccountScene.toggle()
                        addAccountScene = false
                        viewInfoScene = false
                        deleteAccountScene = false
                        editAccountScene = false
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    
                    Button("View your middle of watching Anime") {
                        viewAccountScene.toggle()
                        addAccountScene = false
                        viewInfoScene = false
                        deleteAccountScene = false
                        editAccountScene = false
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                    
                    
                    Button("Delete an Anime") {
                        deleteAccountScene.toggle()
                        addAccountScene = false
                        viewAccountScene = false
                        viewInfoScene = false
                        editAccountScene = false
                    }
                    .padding()
                    .border(Color.white, width: 1)
                    .foregroundColor(.white)
                }
            }
        }
        .onChange(of: AccountData) { newValue in
                    Account = (try? JSONDecoder().decode([String].self, from: newValue)) ?? []
                }
                .onChange(of: UsernameData) { newValue in
                    Username = (try? JSONDecoder().decode([String].self, from: newValue)) ?? []
                }
                .onChange(of: PasswordData) { newValue in
                    Password = (try? JSONDecoder().decode([String].self, from: newValue)) ?? []
                }
                .onChange(of: Account) { newValue in
                    AccountData = try! JSONEncoder().encode(newValue)
                }
                .onChange(of: Username) { newValue in
                    UsernameData = try! JSONEncoder().encode(newValue)
                }
                .onChange(of: Password) { newValue in
                    PasswordData = try! JSONEncoder().encode(newValue)
                }
    }
}

struct AddAccount: View {
    @Binding var addAccountScene: Bool
    @Binding var accounts: [String]
    @Binding var usernames: [String]
    @Binding var passwords: [String]

    @State private var accountWord: String = ""
    @State private var usernameWord: String = ""
    @State private var passwordWord: String = ""
    @State private var filloutPopup = false
    @State private var accountPopup = false
    
    var body: some View {
        VStack() {
            Text("Enter an Account")
                .padding()
                .foregroundColor(.white)
            TextField("Enter an Account", text: $accountWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Username")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Username", text: $usernameWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Password")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Password", text: $passwordWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                if accountWord.isEmpty || usernameWord.isEmpty || passwordWord.isEmpty {
                    filloutPopup = true
                } else if accounts.contains(accountWord) {
                    accountPopup = true
                } else {
                    accounts.append(accountWord)
                    usernames.append(usernameWord)
                    passwords.append(passwordWord)
                    addAccountScene.toggle()
                }
            }
            .padding()
            .border(Color.white, width: 1)
            .foregroundColor(.white)
            
            Button("Go Back") {
                addAccountScene.toggle()
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

struct deleteAccount: View {
    @Binding var accounts: [String]
    @Binding var usernames: [String]
    @Binding var passwords: [String]
    @Binding var deleteAccountScene: Bool
    
    var body: some View {
        VStack() {
            List(accounts.indices, id: \.self) { index in
                Button(action: {
                    accounts.remove(at: index)
                    usernames.remove(at: index)
                    passwords.remove(at: index)
                    deleteAccountScene.toggle()
                }) {
                    Text(accounts[index])
                        .foregroundColor(.white)  // set the text color to white
                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                        .border(Color.black)
                        .background(Color.black)  // set the row background to black
                }
            }
            Button("Go Back") {
                deleteAccountScene.toggle()
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

struct EditInfo: View {
    @Binding var accounts: [String]
    @Binding var usernames: [String]
    @Binding var passwords: [String]
    @Binding var accountSelect: String
    @Binding var usernameSelect: String
    @Binding var passwordSelect: String
    @Binding var place: Int
    @Binding var editInfoScene: Bool
    
    @State private var usernameWord: String = ""
    @State private var passwordWord: String = ""
    
    @State private var filloutPopup: Bool = false
    
    var body: some View {
        VStack() {
            
            Text("Account: /(accountSelect)")
                .padding()
                .foregroundColor(.white)
                .font(.title)
            
            Text("Previous Username: /(usernameSelect)")
                .padding()
                .foregroundColor(.white)
                .font(.title)
            Text("Enter a New Username")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a New Username", text: $usernameWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Previous Password: /(passwordSelect)")
                .padding()
                .foregroundColor(.white)
                .font(.title)
            Text("Enter a New Pasword")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a New Password", text: $passwordWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                if usernameWord.isEmpty || passwordWord.isEmpty {
                    filloutPopup = true
                } else {
                    usernames[place] = usernameWord
                    passwords[place] = passwordWord
                    editInfoScene.toggle()
                }
            }
            .padding()
            .border(Color.white, width: 1)
            .foregroundColor(.white)
            
            if filloutPopup {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Close popup when background is tapped
                        filloutPopup = false
                    }

                VStack(spacing: 20) {
                    Text("You did not fill out all of the requirements")
                    Button("Close") {
                        filloutPopup = false
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
            
            Button("Go Back") {
                editInfoScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

struct EditAccount: View {
    @Binding var accounts: [String]
    @Binding var usernames: [String]
    @Binding var passwords: [String]
    @Binding var accountSelect: String
    @Binding var usernameSelect: String
    @Binding var passwordSelect: String
    @Binding var place: Int
    @Binding var editAccountScene: Bool
    @Binding var editInfoScene: Bool
    
    var body: some View {
        VStack() {
            List(accounts.indices, id: \.self) { index in
                Button(action: {
                    accountSelect = accounts[index]
                    usernameSelect = usernames[index]
                    passwordSelect = passwords[index]
                    place = index
                    editInfoScene = true
                    editAccountScene = false

                }) {
                    Text(accounts[index])
                        .foregroundColor(.white)  // set the text color to white
                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                        .border(Color.black)
                        .background(Color.black)  // set the row background to black
                }
            }
            .listStyle(PlainListStyle())  // Removes default list styling
            .background(Color.black)  // set the list background to black
            
            Button("Go Back") {
                editAccountScene.toggle()
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

struct ViewAccount: View {
    @Binding var viewAccountScene: Bool
    @Binding var viewInfoScene: Bool
    @Binding var accounts: [String]
    @Binding var usernames: [String]
    @Binding var passwords: [String]
    
    @Binding var accountSelect: String
    @Binding var usernameSelect: String
    @Binding var passwordSelect: String
    
    var body: some View {
        VStack() {
            // Contents for your ViewAccount here
            
            List(accounts.indices, id: \.self) { index in
                Button(action: {
                    accountSelect = accounts[index]
                    usernameSelect = usernames[index]
                    passwordSelect = passwords[index]
                    viewInfoScene = true  // Toggle to show the ViewInfo scene
                    viewAccountScene = false  // Close the ViewAccount scene
                }) {
                    Text(accounts[index])
                        .foregroundColor(.white)  // set the text color to white
                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                        .border(Color.black)
                        .background(Color.black)  // set the row background to black
                }
            }
            .listStyle(PlainListStyle())  // Removes default list styling
            .background(Color.black)  // set the list background to black
            
            Button("Go Back") {
                viewAccountScene.toggle()
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

struct ViewInfo: View {
    @Binding var viewInfoScene: Bool
    @Binding var accountSelect: String
    @Binding var usernameSelect: String
    @Binding var passwordSelect: String
    
    var body: some View {
        VStack() {
            Text("Account: \(accountSelect)")
                .foregroundColor(.white)  // set the text color to white
                .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                .border(Color.black)
                .background(Color.black)  // set the row background to black
                .font(.title)
            Text("Username: \(usernameSelect)")
                .foregroundColor(.white)  // set the text color to white
                .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                .border(Color.black)
                .background(Color.black)  // set the row background to black
                .font(.title)
            Text("Password: \(passwordSelect)")
                .foregroundColor(.white)  // set the text color to white
                .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                .border(Color.black)
                .background(Color.black)  // set the row background to black
                .font(.title)
            
            Button("Go Back") {
                viewInfoScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

