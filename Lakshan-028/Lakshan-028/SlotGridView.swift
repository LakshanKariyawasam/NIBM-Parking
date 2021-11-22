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
                }
            }
        }
    }
}
