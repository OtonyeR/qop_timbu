# Quills on Pages Timbu Store App

## Overview
 
This Timbu Store App is built using Flutter. The app displays a list of products fetched from the Timbu API, allows users to view product details, and add products to their shopping bag.

## Features

- Display a list of products from the Timbu API
- View product details in a bottom sheet
- Add products to a shopping bag
- Error handling and refreshing data

## Screenshots

*Include some screenshots of your app here.*

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- An IDE like Visual Studio Code or Android Studio

### Installing

1. Clone the repository
    ```bash
    git clone https://github.com/yourusername/qop_timbu.git
    ```
2. Navigate to the project directory
    ```bash
    cd qop_timbu
    ```
3. Install the dependencies
    ```bash
    flutter pub get
    ```
4. Run the app
    ```bash
    flutter run
    ```

## Project Structure

```
qop_timbu
├── .dart_tool
├── .idea
├── android
├── assets
│   └── bag_icon.png
├── build
├── ios
├── lib
│   ├── components
│   │   └── widgets
│   │       ├── error_box.dart
│   │       └── product_tile.dart
│   ├── models
│   │   └── product.dart
│   ├── screens
│   │   └── shop.dart
│   ├── services
│   │   └── api_services.dart
│   ├── main.dart
├── test
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
├── qop_timbu.iml
└── README.md
```

## Usage

### API Service

The `ApiService` class in `lib/services/api_services.dart` handles the fetching of product data from the Timbu API.

```dart
class ApiService {
  Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('https://api.timbu.com/products'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
```

### Product Model

The `Product` class in `lib/models/product.dart` represents the product data model.

```dart
class Product {
  final String name;
  final double currentPrice;
  final String description;

  Product({required this.name, required this.currentPrice, required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      currentPrice: json['currentPrice'],
      description: json['description'],
    );
  }
}
```

### Shop Screen

The `ShopScreen` widget in `lib/screens/shop.dart` displays the list of products and handles user interactions.

## Contributing

If you want to contribute to this project, feel free to submit pull requests. Please ensure your changes are well-documented and tested.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev)
- [Timbu API](https://api.timbu.com)
