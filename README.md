# Quills on Pages Timbu Store App

## Overview
 
This Timbu Store App is built using Flutter. The app displays a list of products fetched from the Timbu API, allows users to view product details, and add products to their shopping bag.

## Features

- Display a list of products from the Timbu API
- View product details in a bottom sheet
- Add products to a shopping bag
- Error handling and refreshing data

## Screenshots

![Home1](https://github.com/OtonyeR/qop_timbu/blob/main/screenshots/Screenshot_20240707_011054.jpg)
*Caption: The Home Screen showcasing our products.*

![Screenshot_20240707_034207](https://github.com/OtonyeR/qop_timbu/assets/78686910/e4b36acc-6ec7-4937-abe5-44ae72b9d7de)
*Caption: The Home Screen showcasing filtered products by category*

https://drive.google.com/file/d/1mO5R9fr4bfhHgRhHKTEqz3QpsQ22D2lR/view?usp=sharing
*Caption: Your Home Screen with product description*


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
