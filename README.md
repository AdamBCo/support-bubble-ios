# Support Bubble iOS SDK

Support Bubble is an easy-to-integrate iOS SDK that enables your users to communicate with your staff through a seamless chat interface. Built for SwiftUI applications, it requires iOS 16.0 or later.

## Features

- **User Communication**: Allow your users to easily start conversations with your support team directly from within your app.
- **Ticket Management**: Users can view and manage their support tickets.
- **Seamless Integration**: Designed to be easily integrated into any SwiftUI application.
- **Secure**: Ensure secure communication by setting up client IDs and tokens.

## Requirements

- iOS 16.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

Support Bubble SDK can be installed using Swift Package Manager (SPM).

1. In Xcode, navigate to `File` > `Add Packages...`
2. Enter the Support Bubble SDK repository URL into the search field.
3. Select the Support Bubble package and choose the version you want to integrate.
4. Click `Add Package`.

## Usage

To use Support Bubble in your project, you need to configure it with your client ID and token, and then present the tickets view where needed.

### Configuration

First, import Support Bubble in your application delegate or initial view:

```swift
import SupportBubble
```

Configure the SDK with your client ID and token:

```swift
SupportBubble.shared.clientID = "YOUR_CLIENT_ID"
SupportBubble.shared.clientToken = "YOUR_CLIENT_TOKEN"
```

### Showing the Tickets View
To show the tickets view to the user, call the showTicketsView method when appropriate (e.g., after a user action):

```swift
SupportBubble.shared.showTicketsView()
```

### Logout
To log out the user from the Support Bubble session, call the logout method:

```swift
SupportBubble.shared.logout()
```

Customization
Currently, Support Bubble offers limited customization options. Stay tuned for future updates where more customization will be available.

Support
If you encounter any issues or require further assistance, please contact our support team at support@example.com.

License
Support Bubble is available under the MIT license. See the LICENSE file for more info.
