# My Card Flutter App

This is a Flutter application that allows users to add and manage their credit card details.

## Features

- Add credit card details including card number, full name, CVV, expiration date, and issuing country.
- Validate input fields and display error messages for missing or invalid data.
- Scan card details using the device's camera.
- View and delete added cards.

## Installation

1. Make sure you have Flutter installed on your system. If not, refer to the official Flutter documentation for installation instructions: [Flutter Installation](https://flutter.dev/docs/get-started/install).

2. Clone the repository or download the source code files.

3. Open the project in your preferred code editor.

4. Run the following command in the terminal to fetch the required dependencies: flutter pub get

5. Connect your mobile device or start an emulator.

6. Run the app using the following command: flutter run

## Usage

1. Launch the app on your mobile device or emulator.

2. On the home screen, you'll see input fields for card details such as card number, full name, CVV, expiration date, and issuing country.

3. Fill in the required information for a new card.

4. The app will validate the input fields, displaying error messages if necessary.

5. Optionally, you can use the scan button to capture card details using the device's camera.

6. After entering valid card details, tap the "Add Card" button to add the card to the list.

7. The added cards will appear in a scrollable list below the form.

8. To delete a card, tap the "Delete" button next to the respective card in the list.

## Dependencies

The app uses the following dependencies:

- `flutter/material`: Provides the UI components and material design theming.
- `flutter/services`: Enables communication with native platform APIs.
- `image_picker`: Allows image selection from the device's gallery or camera.
- `my_card/utils/card_utils.dart`: Contains utility functions for card processing.

Please make sure to check the `pubspec.yaml` file for the specific versions of the dependencies used in this project.
