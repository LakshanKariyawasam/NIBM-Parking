//
//  HomeView.swift
//  Lakshan-028
//
//  Created by on 11/16/21.
//

import SwiftUI
import FirebaseDatabase

struct HomeView: View {
    @State var data: [DataSnapshot] = [];
    @State var Grid : [Int] = [];
   
    @State var isLoaded = false;

    var body: some View {
        VStack{
            SlotGridView(data: self.$data,Grid: self.$Grid)
        }.onAppear {
            if(!isLoaded){
                self.loadData();
                self.isLoaded = true;
            }
        }
    }
    
    
    func loadData(){
        let controller = FirebaseController()
        
        controller.getAllSlots() {(success) in
            self.data = success;
            for i in stride(from: 0, to: self.data.count, by: 2){
               if i != self.data.count{
                  self.Grid.append(i)
               }
            }
        }
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
