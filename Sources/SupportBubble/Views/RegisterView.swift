import SwiftUI

@available(iOS 13.0, *)
struct RegisterView: View {
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var isRegistering: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                TextField("Name", text: $name)
                TextField("Username", text: $username)
            }
            
            Section {
                Button(action: {
                    registerUser()
                }) {
                    Text(isRegistering ? "Registering..." : "Register")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .disabled(isRegistering)
                .padding()
                .background(isRegistering ? Color.gray : Color.blue)
                .cornerRadius(8)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func registerUser() {
        guard !name.isEmpty, !username.isEmpty else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        isRegistering = true
        let registerData = RegisterRequest(name: name, username: username)
        
        Task {
            do {
                let response: RegisterResponse = try await NetworkManager.shared.postRequest(path: "customers", data: registerData)
                print("TOKEN: ", response.token)
                alertMessage = "Registration successful!"
            } catch {
                alertMessage = "Registration failed: \(error.localizedDescription)"
            }
            isRegistering = false
            showAlert = true
        }
    }
}
