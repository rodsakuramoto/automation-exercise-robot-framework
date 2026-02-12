# Automation Exercise - Robot Framework Project

This project contains automated test scripts for the [Automation Exercise](http://automationexercise.com) website, developed using **Robot Framework** and **SeleniumLibrary**.

## Project Structure

The project follows a modular structure to separate test data, page elements, keywords, and test cases:

- **`test_cases/`**: Contains the test suite files (e.g., `test_cases.robot`).
- **`steps/`**: Contains the keyword implementations (Step Definitions) handling the logic.
- **`elements/`**: Contains the locators for web elements, following the Page Object Model pattern.
- **`resource/`**: Common resource files and library imports.

## Prerequisites

Ensure you have the following installed:

- Python (3.x recommended)
- Chrome Browser
- ChromeDriver (Ensure it matches your Chrome version and is in your system PATH)

## Installation

1. Clone the repository.
2. Install the required Python libraries:

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
pip install robotframework-faker
```

## Running the Tests

To run all test cases and save the reports to a `results` folder, execute the following command from the project root:

```bash
robot -d results test_cases/test_cases.robot
```

### Running Specific Tests

You can run specific tests using tags (e.g., `smoke`, `regression`, `checkout`):

```bash
robot -d results -i smoke test_cases/test_cases.robot
```

## Test Coverage

The project covers various end-to-end scenarios including:

- **User Management**: Registration, Login, Logout, Delete Account.
- **Products**: Browsing, Searching, Category/Brand filtering, Product Details.
- **Shopping Cart**: Adding items, Quantity verification, Removing items.
- **Checkout**: Address verification, Payment processing, Order placement, Invoice download.
- **Miscellaneous**: Contact Us form, Subscription, Scroll functionality.

## Reporting

After execution, Robot Framework generates detailed HTML reports (`log.html` and `report.html`) in the `results` directory.