# OpenCart Enterprise BDD Automation Framework

A robust, thread-safe automated testing framework built for the OpenCart e-commerce platform. Designed to handle dynamic data generation and parallel execution without database collisions.

## 🚀 Tech Stack
* **Language:** Java 17
* **Core Engine:** Selenium WebDriver 4.x
* **Framework:** Cucumber BDD & TestNG
* **Data Strategy:** DataFaker (Dynamic User Generation)
* **Reporting:** ExtentReports (Spark)
* **Build Tool:** Maven

## 🏗️ Architecture Highlights
* **ThreadLocal DriverFactory:** Ensures 100% thread-safe parallel execution by isolating WebDriver instances across multiple cores.
* **Dynamic Test Data:** Utilizes `DataFaker` to generate isolated, on-the-fly email addresses and user profiles per thread, bypassing storefront rate-limiting and DB collisions.
* **AJAX-Aware Page Objects:** Implements explicit waits tailored for OpenCart's asynchronous checkout accordion.

## ⚙️ Local Execution
To execute the suite locally using headless Chrome browsers:
```bash
mvn clean test

## ⚙️ To execute a specific module (e.g., Checkout):
mvn clean test -Dcucumber.filter.tags="@checkout"

## Test Reporting
The framework automatically generates interactive HTML reports. Upon execution completion, open the following file in any browser:
test-output/SparkReport/Index.html