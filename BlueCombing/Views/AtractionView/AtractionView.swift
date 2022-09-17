//
//  AtractionView.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/16.
//

import SwiftUI

struct AtractionView: View {
    var body: some View {
        
        NavigationView{
            
            CustomTabView()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
    }
}

struct CustomTabView : View {
    
    @State var selectedTab = "img_event"
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            
            // Using Tab View For Swipe Gestures...
            // if you dont need swipe gesture tab change means just use switch case....to switch views...
            
            TabView(selection: $selectedTab) {
                
                Folder()
                    .tag("img_event")
                
                TourView()
                    .tag("img_tour")
                
                Settings()
                    .tag("img_leisure")
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 18){
                
                ForEach(tabs,id: \.self){image in
                    
                    TabButton(image: image, selectedTab: $selectedTab)
                    
                }
            }
        }
    }
}

// tabs...
// Image Names...
var tabs = ["img_event","img_tour","img_leisure"]

struct TabButton : View {
    
    var image : String
    @Binding var selectedTab : String
    
    var body: some View{
        
        Button(action: {selectedTab = image}) {
            
            Image(image)
                .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color.combingBlue4 : Color.combingGray3)
                .padding(.leading, 21)
                .padding(.top, 51)
        }
    }
}
// TabViews...

struct Folder : View {
    
    var body: some View{
        
        VStack{
            
            Text("Folder")
        }
    }
}

struct Settings : View {
    
    var body: some View{
        
        VStack{
            
            Text("Settings")
        }
    }
}
struct AtractionView_Previews: PreviewProvider {
    static var previews: some View {
        AtractionView()
    }
}
