//
//  NavigationView.swift
//  CampusNavigator
//
//  Created by suresh 030 on 2025-02-26.
//

import SwiftUI
import MapKit

struct NavigationView: View {
    @State private var destination: String = ""
    @State private var selectedLocation: String = ""
   
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 20) {
            
            HStack{
                
                Text("Navigation")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
                MapViewSnapshot()
                    .frame(height: 180)
                    .cornerRadius(10)
           
            Text("Where do you want to go?")
                .font(.headline)
           
            VStack(spacing: 10) {
                TextField("Start location", text: $destination)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
               
                TextField("Select where you want to go", text: $selectedLocation)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }
           
            NavigationLink(destination: NavigationGuide()) {
                Text("Navigate")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.accents)
                    .cornerRadius(10)
            }
           
            VStack(alignment: .leading, spacing: 10) {
                Text("See a QR code nearby?")
                    .font(.headline)
                
                Text("Tap the button below to scan the QR code and navigate.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: QRScannerView()) {
                    Text("Scan QR")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.secondarys)
                        .cornerRadius(10)
                }
            }
            }
            Spacer()
        }
        .padding()
    }
}

struct MapViewSnapshot: View {
    @State private var snapshotImage: UIImage? = nil
   
    let coordinate = CLLocationCoordinate2D(latitude: 6.9022, longitude: 79.8607)

    var body: some View {
        ZStack {
            if let image = snapshotImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        generateSnapshot()
                    }
            }
        }
    }

    private func generateSnapshot() {
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        options.size = CGSize(width: 400, height: 200)
       
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if let snapshot = snapshot {
                snapshotImage = snapshot.image
            }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}

