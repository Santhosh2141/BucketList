//
//  ContentView.swift
//  BucketList
//
//  Created by Santhosh Srinivas on 20/09/25.
//

import SwiftUI
import MapKit

extension FileManager{
    func storeData(data: String){
        let saveData = Data(data.utf8)
        let url = URL.documentsDirectory.appending(path: "message.txt")
        
        do {
            // atomic means completely at once all data
            try saveData.write(to: url, options: [.atomic, .completeFileProtection])
            let input = try String(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readData() -> String {
        let url = URL.documentsDirectory.appending(path: "message.txt")
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to Read Data")
            return ""
        }
        
        let result = try? String(data: data, encoding: .utf8)
        return result ?? "No Value Available"
    }
}
struct User: Identifiable, Comparable{
    let id = UUID()
    let nameF: String
    let nameL: String
    
    // less than is the operator to perform. Static means it belons to the User Struct nad not a single object
    static func <(lhs: User, rhs: User) -> Bool{
        lhs.nameL < rhs.nameL
    }
}
struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct Location: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
struct ContentView: View {
    let values = [1,2,5,3,8,6].sorted()
    let users = [
        User(nameF: "Lewis", nameL: "Hamilton"),
        User(nameF: "Max", nameL: "Verstappen"),
        User(nameF: "Lando", nameL: "Norris"),
        User(nameF: "Oscar", nameL: "Piastri")
    ].sorted()
    // using sorted for this wont work.
    // and for sorting we have to call sorted inside the view evertyime we use. but, in structs its inbuilt cuz Ints are comparable
    enum LoadingState {
        case loading, success, failed
    }
    @State private var loadingState = LoadingState.failed
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 12.971599, longitude: 77.5775), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    // for annotations, we need a data type to find the location, a list to store the locations and pass this into the map view
    
    let location = [
        Location(name: "Brundavan Gardens", coordinate: CLLocationCoordinate2D(latitude: 12.887746, longitude: 77.553095)),
        Location(name: "Forum Mall", coordinate: CLLocationCoordinate2D(latitude: 12.888289, longitude: 77.562505))
    ]
    var body: some View {
        NavigationStack{
            VStack {
                List(users){ user in
                    Text("\(user.nameL), \(user.nameF)")
                }
                Text("Hello World")
                    .onTapGesture {
    //                    let str = "Test Message"
    //                    let url = getDocuments().appendingPathComponent("message.txt")
    //                    do {
    //                        try str.write(to: url, atomically: true, encoding: .utf8)
    //                        let input = try String(contentsOf: url)
    //                        print(input)
    //                    } catch {
    //                        print(error.localizedDescription)
    //                    }
                        FileManager.default.storeData(data: "Test Message")
                    }
                Button("Write") {
    //                let data = Data("Test Message".utf8)
    //                let url = URL.documentsDirectory.appending(path: "message.txt")
    //                do {
    //                    // atomic means completely at once all data
    //                    try data.write(to: url, options: [.atomic, .completeFileProtection])
    //                    let input = try String(contentsOf: url)
    //                    print(input)
    //                } catch {
    //                    print(error.localizedDescription)
    //                }
                    FileManager.default.storeData(data: "Test Message")
                }
                Button("Read"){
                    print(FileManager.default.readData())
                }
                
                Map(coordinateRegion: $mapRegion, annotationItems: location){ location in
    //                MapMarker(coordinate: location.coordinate)
                    MapAnnotation(coordinate: location.coordinate){
                        VStack{
                            Text(location.name)
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .frame(width: 33, height: 33)
                        }
                    }
                }
    //            if Bool.random(){
    //                Rectangle()
    //            } else {
    //                Circle()
    //            }
                
//                if loadingState == .loading{
//                    LoadingView()
//                } else if loadingState == .success {
//                    SuccessView()
//                } else if loadingState == .failed {
//                    FailedView()
//                }
                
//                switch loadingState {
//                case .loading:
//                    LoadingView()
//                case .success:
//                    SuccessView()
//                case .failed:
//                    FailedView()
//                }
            }
            .padding()
            NavigationLink("Go to FaceID View", destination: FaceIDView())
            
        }
    }
    
    // Apple provides a permanant storage location called Documents for all devices to save data from applications
    func getDocuments() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
