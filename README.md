# Time Pulse App

A mobile application for employyes to track their time and attendance. The app allows users to check in/ out, view their attendance history, Request vacation, and view their available days off vacations balance.

## ✨ Features

- **GPS Tracking Sysytem** 
  - Allows the user to check in/out while their device's GPS location is in the company location area.
- **Secure Authentication** 🔒
  - Firebase-powered user registration & login.
- **Attendance History** 📆
  - Users can view their check in/out operations history.
- **Vacations Requests System**
  - Request vacations with a start and end date.
  - Write the vacation reason.
- **User Profile Management** 👤
  - Edit personal information.
  - View vacation days balance.
- **Dark/Light Theme** 🌓
- **Multi-language Support** 🌐 - (English/Arabic)
- **Admin DashBoard Management Sysytem** 📱
  - View all users and their attendance history.
  - View all vacations requests.
  - Accept /Reject vacations requests.
  - Add new users.

## 🔥 Firebase Integration

### Firebase Authentication

- **Secure User Management**  
  Implemented with email/password authentication.
  Distrebute user mail and admin mail securely.
- **State Persistence**  
  Maintains user session across app restarts

### Cloud Firestore

- **Real-time Sync** 🔄
  Instant updates for vacations requests between users and admin.
- **Optimistic UI Updates** ⚡
  Immediate visual feedback for user actions

## 📱 App Demo Video

|               Employee Screen Record                         |                      Admin Screen Record                      |
| ------------------------------------------------------------ | ------------------------------------------------------------- |
| [![Employee Screen Record](https://drive.google.com/file/d/1yb8MJNnSlcsVJIFRsGKnvvL9cE2jDTze/view?usp=drive_link)] |   [![Admin Screen Record](https://drive.google.com/file/d/19eVvaFDCLbTFhtpP5jB-DdNPi1xQeTJy/view?usp=drive_link)]   |

## 🛠 Key Components

### 🔐 Authentication Flow

#### Login Page

- **Email/Password Validation**
- **Error Handling**
- **Password Recovery Flow**
- **Admin/ User Account Distribution**
- **Success Dialog Feedback** 💬

### 🏠 Home Page

- **Dynamic Button Navigation Bar**
- **Check In/Out Toggle Button**

### Attendance History Page

### Vacation Request Page

### 👤 Profile Management

- **Data Persistence**  
  SharedPreferences + Firestore sync
- **Fingerprint Auth to Access**
- **Editable Fields**
  - Name
  - Email
  - Employee ID
  - Profile Picture
  - Remaining Vacation Days

### **Settings Page**

- **Theme Switcher** (Light/Dark)
- **Language Switcher** (English/Arabic)

### **Admin DashBoard**

- **User Management** (Add/Search)
  - Add User.
  - Search User.
  - Show User Attendance History.
- **Vacation Request Management** (Accept/Reject)
- **Settings** (Theme/Language)

## 🚀 Getting Started

To get started with this project, follow these steps:

1. **Clone the repository**:
   ```sh
   git clone https://github.com/OmarAmeer96/Time-Pulse.git
   ```
2. **Navigate to the project directory**:
   ```sh
   cd Time-Pulse
   ```
3. **Install dependencies**:
   ```sh
   flutter pub get
   ```
4. **Run the app**:
   ```sh
   flutter run
   ```
