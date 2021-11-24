//
//  SlotGridView.swift
//  Lakshan-028
//
//  Created by on 11/16/21.
//

import SwiftUI
import Foundation
import FirebaseDatabase

struct SlotGridView : View {
    
    @Binding var data : [DataSnapshot]
    @Binding var Grid : [Int]
    @State var reload = false
    
    var body: some View {
        VStack {
            if !self.Grid.isEmpty {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing : 15){
                        ForEach(self.Grid,id: \.self){i in
                            HStack(spacing: 15){
                                ForEach(i...i+2,id: \.self){j in
                                    VStack{
                                        if j != self.data.count{
                                            CollectionCellView(data: self.data[j])
                                        }
                                    }
                                }
                                
                                if i == self.Grid.last! && self.data.count % 2 != 0{
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                    }
                    .padding()
                }.gesture(
                    DragGesture().onChanged { value in
                       if value.translation.height > 0 {
                          print("Scroll down")
                        //self.reload = true;
                        self.data = [];
                        self.Grid = [];
                        self.loadData();
                       
                       } else {
                          print("Scroll up")
                       }
                    }
                 )
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

