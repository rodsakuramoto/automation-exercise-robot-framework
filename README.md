# Automation Exercise - Robot Framework Project

[![Robot Framework Tests](https://github.com/rodsakuramoto/automation-exercise-robot-framework/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/rodsakuramoto/automation-exercise-robot-framework/actions/workflows/robot-tests.yml)

This project contains automated test scripts for the [Automation Exercise](http://automationexercise.com) website, developed using **Robot Framework** and **SeleniumLibrary**.

---

## 🚀 Highlights

* ✅ End-to-end UI automation using Robot Framework
* ⚡ Parallel test execution using **Pabot**
* 🔄 Continuous Integration configured with **GitHub Actions**

---

## 📁 Project Structure

The project follows a modular structure to separate test data, page elements, keywords, and test cases:

* **`test_cases/`**: Contains the test suite files (e.g., `test_cases.robot`).
* **`steps/`**: Contains the keyword implementations (Step Definitions) handling the logic.
* **`elements/`**: Contains the locators for web elements, following the Page Object Model pattern.
* **`resource/`**: Common resource files and library imports.

---

## ⚙️ Prerequisites

Ensure you have the following installed:

* Python (3.x recommended)
* Chrome Browser
* ChromeDriver (Ensure it matches your Chrome version and is in your system PATH)

---

## 📦 Installation

1. Clone the repository.
2. Install the required Python libraries:

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
pip install robotframework-faker
pip install robotframework-pabot
```

---

## ▶️ Running the Tests

### Run tests (sequential execution)

```bash
robot -d results test_cases/
```

### Run specific tests by tag

```bash
robot -d results -i smoke test_cases/
```

---

## ⚡ Running Tests in Parallel (Pabot)

This project is configured to support parallel execution using **Pabot**, which significantly reduces execution time.

### Run tests in parallel

```bash
pabot -d results test_cases/
```

### Control number of parallel processes

```bash
pabot --processes 4 -d results test_cases/
```

> Adjust the number of processes based on your machine capabilities.

---

## 🤖 CI/CD with GitHub Actions

This repository includes a **GitHub Actions workflow** that automatically runs the tests on every push and pull request.

### What is configured:

* ✅ Automatic test execution
* 📊 Test reports generation
* 🔔 Build status badge (see top of this README)

The workflow file is located at:

```
.github/workflows/robot-tests.yml
```

This ensures continuous validation of the project without needing manual execution.

---

## 🧪 Test Coverage

The project covers various end-to-end scenarios including:

* **User Management**: Registration, Login, Logout, Delete Account.
* **Products**: Browsing, Searching, Category/Brand filtering, Product Details.
* **Shopping Cart**: Adding items, Quantity verification, Removing items.
* **Checkout**: Address verification, Payment processing, Order placement, Invoice download.
* **Miscellaneous**: Contact Us form, Subscription, Scroll functionality.

---

## 📊 Reporting

After execution, Robot Framework generates detailed HTML reports (`log.html` and `report.html`) in the `results` directory.

---

## 💡 Tips

* Use parallel execution (Pabot) for faster feedback during development
* Rely on GitHub Actions to validate your changes automatically
* Keep tests independent to maximize parallel performance
