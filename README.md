# SWP391 - Swimming Pool Management System (SPMS)

A comprehensive web application built with Java Servlets and JSP for managing all aspects of a swimming pool business. The system provides distinct functionalities for different user roles, including administrators, managers, staff, and customers, all through a modern, responsive web interface.

## Key Features

The application is divided into modules based on user roles, providing a tailored experience for each.

### 1. General & Customer Features
- **User Authentication:** Secure registration and login for all users.
- **Google OAuth 2.0:** Users can sign up or log in quickly using their Google accounts.
- **Pool Browsing:** View a list of available swimming pools with detailed information and images.
- **Online Booking:** Customers can book tickets for specific time slots.
- **Service Selection:** Add rental services (e.g., towels, swimwear) to a booking.
- **Online Payments:** Integrated with the **VNPay payment gateway** to facilitate secure online transactions.
- **Booking History:** View past and upcoming bookings.
- **User Profile Management:** Customers can view and edit their personal information and change their passwords.

### 2. Admin Features
- **Analytics Dashboard:** A rich dashboard with charts and statistics visualizing:
  - Monthly revenue and user growth.
  - Pool and device operational status.
  - Booking trends and user demographics.
- **Pool Management:** Full CRUD (Create, Read, Update, Delete) functionality for swimming pools and branches.
- **User Management:** Manage all system accounts, including Managers, Staff, and Customers.
- **Contact Management:** View and respond to customer inquiries.

### 3. Manager Features
- **Manager Dashboard:** A dedicated dashboard for overseeing pool operations.
- **Device Management:** Track and manage pool equipment (e.g., pumps, lights).
- **Ticket & Discount Management:** Create and manage ticket types and promotional discounts.
- **Feedback Management:** View and reply to customer feedback for their specific pool.
- **Staff Management:** View information about staff members at their branch.

### 4. Staff Features
- **Customer Check-in:** A simple interface for staff to validate tickets and check customers in.
- **On-site Sales:** Handle point-of-sale transactions for tickets and services.
- **Device & Service Reporting:** Report issues with devices or services.

## Technology Stack

- **Backend:** Java (Servlet, JSP, JSTL, JDBC)
- **Frontend:** HTML, Tailwind CSS, JavaScript
- **Database:** Microsoft SQL Server
- **Build Tool:** Apache Ant
- **Charting Library:** Chart.js
- **Server:** Apache Tomcat or similar servlet container.

## Highlighted Integrations

This project incorporates several modern technologies to enhance its functionality:

- **Google Authentication (OAuth 2.0):** Provides a seamless and secure login experience.
- **VNPay Payment Gateway:** Enables real-time, secure online payments for bookings.
- **AJAX-driven UI:** The admin dashboard dynamically loads data without page reloads for a smoother user experience.
- **Tailwind CSS:** A modern, utility-first CSS framework is used to create a clean and responsive user interface.
- **Apache POI:** Used for features that may involve generating or handling Microsoft Office documents (e.g., Excel reports).

## Getting Started

To set up and run this project locally, follow these steps:

### Prerequisites
- **JDK** 8 or higher.
- **Apache Tomcat** 8.5 or higher.
- **Microsoft SQL Server** with an accessible database instance.
- **Apache Ant** for building the project.

### 1. Database Setup
1.  Open your SQL Server management tool.
2.  Create a new database for the project.
3.  Execute the SQL scripts provided in the root directory (`PoolV1.sql`, `InsertData_1.sql`) to create the schema and populate initial data.

### 2. Configuration
1.  Open the project in your IDE (e.g., NetBeans, IntelliJ, Eclipse).
2.  Locate the database connection configuration within the Java source code (likely in a `dal` or `context` package).
3.  Update the connection string, username, and password to match your local SQL Server instance.

### 3. Build the Project
1.  Navigate to the project's root directory (`SWP391_G3_SPMS`).
2.  Run the Ant build command from your terminal:
    ```bash
    ant dist
    ```
3.  This will compile the Java code and create a `.war` file in the `dist` directory.

### 4. Deployment
1.  Copy the generated `.war` file from the `dist` directory.
2.  Paste it into the `webapps` directory of your Apache Tomcat installation.
3.  Start the Tomcat server. The application will be deployed automatically.
4.  Access the application in your web browser, typically at `http://localhost:8080/SWP391_G3_SPMS/`.

## Project Structure

- **/src/java**: Contains the Java source code (Servlets, DAOs, Models).
- **/web**: Contains all web-related files, including JSPs, CSS, JavaScript, and images.
- **/lib**: Contains the required Java libraries (.jar files).
- **build.xml**: The Apache Ant script for building the project.
- **\*.sql**: SQL scripts for database setup.
