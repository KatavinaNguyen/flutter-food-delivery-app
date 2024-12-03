# Flutter Food Delivery App
This is a cross-platform food delivery application created during my junior year as a group project over the summer. The app uses Firebase for backend services, providing user authentication, real-time data synchronization, and seamless functionality on both Android and iOS platforms.

A special thank you to my teammates—I'll always appreciate the time we had working together!

## Features 
* **Secure login and registration** using Firebase Authentication.
* **Real-time updates** with Cloud Firestore for data synchronization.
* Compatible with both **Android** and **iOS** platforms.
* Switch between **light** and **dark mode**.
* Fully functioning **preset food menu**.
* Customizable **Food Item Add-ons**.
* Add items to your **cart** and manage orders.
* View detailed **order receipts** after placing orders.
* Secure and reliable **payment processing** for completed transactions.
* Ensures all **user inputs are validated**, correct, and complete.
* Recover accounts via **email password reset** functionality. 

## Tech Stack 
* **Frontend:** Flutter (Dart)
* **Backend:** Firebase (Authentication, Firestore)

## [Watch Demo](https://youtu.be/QnRgXUTsZNY)

<a href="https://youtu.be/LXzYOfntCcw">
  <img src="https://github.com/user-attachments/assets/01027f8b-0f30-4530-8c5b-645bdfe64a8d" alt="Watch Demo" />
</a>

## Setup
1. Install Flutter by downloading the SDK for your OS from this website
   ```
   flutter.dev
   ```
2. Clone the Repository
   ```
   https://github.com/KatavinaNguyen/flutter-food-delivery-app.git
   ```
3. Set Up Firebase on Firebase Console and Add project
   ```
   https://console.firebase.google.com/
   ```
5. Add API Key within this file
   ```
   /lib/firebase_options.dart
   ```
6. Run the App
   ```
   flutter run
   ```
7. Open in an Emulator (Android Studio or Xcode) or Physical Device (USB)

## How to Use 
1. Open the app and login or register as a new user.
2. Browse the preset food menu and customize items as needed.
3. Add your selected items to the cart.
4. Proceed to the checkout screen, handle payment, and place your order.
5. View the order receipt. 
