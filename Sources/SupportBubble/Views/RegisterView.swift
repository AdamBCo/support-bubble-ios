import SwiftUI

@available(iOS 14.0, *)
struct RegisterView: View {
    
    @AppStorage("token") private var token: String?
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var isRegistering: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                TextField("Name", text: $name)
                    .textContentType(.name)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
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
        guard !name.isEmpty, !email.isEmpty else {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        isRegistering = true
        let registerData = RegisterRequest(name: name, email: email)
        
        Task {
            do {
                let response: RegisterResponse = try await NetworkManager.shared.postRequest(
                    path: "customers",
                    data: registerData
                )
                SupportBubble.userID = response.id
                SupportBubble.userToken = response.token
                token = response.token
            } catch {
                alertMessage = "Registration failed: \(error.localizedDescription)"
                showAlert = true
            }
            isRegistering = false
        }
    }
}
