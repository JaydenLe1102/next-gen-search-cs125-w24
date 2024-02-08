//
//  CustomTextField.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/7/24.
//

import SwiftUI

struct CustomTextField: View {
    var icon: String
    var iconColor: Color = .gray
    var hint: String
    
    //Hide textfield
    var isPassword: Bool = false
    @Binding var value: String
    //view properties
    @State private var showPassword: Bool = false
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
            //Since need same width to align textfields equally
                .frame(width:30)
            //slightly bringing down
                .offset(y:2)
            
            VStack(alignment: .leading,  spacing: 8, content: {
                if isPassword {
                    Group {
                        //reveal pw when user want to show pw
                        if showPassword {
                            TextField(hint, text: $value)
                        }
                        else {
                            SecureField(hint, text: $value)
                        }
                    }
                } else {
                    TextField(hint, text: $value)
                }
                
                Divider()
            })
            .overlay(alignment: .trailing) {
                //password reveal button
                if isPassword {
                    Button(action: {
                        withAnimation{
                            showPassword.toggle()
                        }
                    }, label: {
                        Image(systemName: showPassword ?  "eye" : "eye.slash")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
       })
    }
}

//#Preview {
//    CustomTextField()
//}
