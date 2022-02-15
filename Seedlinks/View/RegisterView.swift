//
//  RegisterView.swift
//  Seedlinks
//
//  Created by Francesco Puzone on 15/02/22.
//

import Foundation
import SwiftUI
import AuthenticationServices


struct RegisterView: View {
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    var body: some View {
        VStack {
            Text("Get started!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text("Use your email to create an account")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            VStack {
                Text("Username")
                    .font(.caption)
                    .padding(.top, 30.0)
                    .frame(width: 370, height: 10, alignment: .leading)
                UsernameTextField(username: $username)
                Text("E-mail")
                    .font(.caption)
                    .padding(.top, 30.0)
                    .frame(width: 370, height: 10, alignment: .leading)
                emailTextField(email: $email)
                Text("Password")
                    .font(.caption)
                    .padding(.top, 30.0)
                    .frame(width: 370, height: 10, alignment: .leading)
                PasswordSecureField(password: $password)
                if authenticationDidFail {
                    Text("Information not correct. Try again.")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if self.username == storedUsername && self.password == storedPassword {
                        self.authenticationDidSucceed = true
                        self.authenticationDidFail = false
                    } else {
                        self.authenticationDidFail = true
                    }
                }) {
                    RegisterButtonContent()
                }
            }
            .padding(.bottom, 3.0)
            HStack{
                Rectangle()
                    .frame(width: 50.0, height: 1.0)
                Text("Or continue with")
                Rectangle()
                    .frame(width: 50.0, height: 1.0)
                
            }
            SignInWithAppleButton(
                onRequest: { request in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                },
                onCompletion: { result in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                }
            )
                .frame(width: 200.0, height: 40.0)
                .cornerRadius(10)
                .padding()
            //            Qui da mettere quello di Google
            SignInWithAppleButton(
                onRequest: { request in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                },
                onCompletion: { result in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                }
            )
                .frame(width: 200.0, height: 40.0)
                .cornerRadius(10)
                .padding()
            //            Qui da mettere quello di Facebook
            SignInWithAppleButton(
                onRequest: { request in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                },
                onCompletion: { result in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                }
            )
                .frame(width: 200.0, height: 40.0)
                .cornerRadius(10)
                .padding()
            
            HStack{
                Text("Already registered?")
                Text("Sign in now!")
                //                    .onTapGesture {
                //                        <#code#>
                //                    }
            }
        }
        .frame(width: 400.0, height: 600.0)
        
    }
}
struct emailTextField : View {
    
    @Binding var email: String
    
    var body: some View {
        return TextField("name@example.com", text: $email)
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .cornerRadius(10.0)
            .padding(.bottom, 20)
    }
}

struct RegisterButtonContent : View {
    var body: some View {
        return Text("Register")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 320, height: 60)
            .background(Color.accentColor)
            .cornerRadius(10.0)
    }
}

struct ContentView_Previews6: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
