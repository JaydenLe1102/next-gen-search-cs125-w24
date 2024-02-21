//
//  CustomTextField.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/7/24.
//

import SwiftUI

struct CustomTextField: View {
    var icon: String
    var hint: String
    
    var isPassword: Bool = false
    @Binding var value: String
    @State private var showPassword: Bool = false
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            Image(systemName: icon)
                .foregroundStyle(.teal)
                .frame(width:30)
                .offset(y:2)
            
            VStack(alignment: .leading,  spacing: 8, content: {
                if isPassword {
                    Group {
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
                if isPassword {
                    Button(action: {
                        withAnimation{
                            showPassword.toggle()
                        }
                    }, label: {
                        Image(systemName: showPassword ?  "eye" : "eye.slash")
                            .foregroundStyle(.teal)
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
