<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) request.getAttribute("user");
    String displayName = user != null ? user.getUsername() : "Choose a display name";
    String name = user != null ? user.getFull_name() : "John Doe";
    String email = user != null ? user.getEmail() : "john.doe@example.com";
    String phone = user != null && user.getPhone() != null ? user.getPhone() : "Add your phone number";
    String address = user != null && user.getAddress() != null ? user.getAddress() : "Add your address";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personal Details - YourBooking.com</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Custom CSS -->
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">YourBooking.com</a>
            <div class="d-flex align-items-center">
                <button class="btn btn-link text-white">
                    <i class="fas fa-question-circle"></i>
                </button>
                <div class="dropdown">
                    <button class="btn btn-link text-white dropdown-toggle" type="button" id="userMenu" data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle"></i>
                        <span class="ms-2"><%= displayName %></span>
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container my-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action active">
                        <i class="fas fa-user me-2"></i> Personal details
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-lock me-2"></i> Security settings
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-credit-card me-2"></i> Payment methods
                    </a>
                </div>
            </div>

            <!-- Personal Details Form -->
            <div class="col-md-9">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="card-title">Personal details</h2>
                            <div class="position-relative">
                                <img src="https://via.placeholder.com/64" class="rounded-circle" alt="Profile Picture">
                                <button class="btn btn-sm btn-primary position-absolute bottom-0 end-0" style="border-radius: 50%;">
                                    <i class="fas fa-camera"></i>
                                </button>
                            </div>
                        </div>
                        <p class="text-muted">Update your information and find out how it's used.</p>
                        <% if (request.getAttribute("updateSuccess") != null) { %>
                            <div class="alert alert-success"><%= request.getAttribute("updateSuccess") %></div>
                        <% } else if (request.getAttribute("updateError") != null) { %>
                            <div class="alert alert-danger"><%= request.getAttribute("updateError") %></div>
                        <% } %>
                        <form id="personalDetailsForm" method="post" action="profile">
                            <!-- Name -->
                            <div class="detail-row">
                                <div class="row align-items-center py-3 border-bottom">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Name</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value" id="nameValue"><%= name %></span>
                                        <div class="edit-field d-none">
                                            <input type="text" class="form-control" name="full_name" value="<%= name %>">
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button visible">Edit</button>
                                    </div>
                                </div>
                            </div>
                            <!-- Display Name -->
                            <div class="detail-row">
                                <div class="row align-items-center py-3 border-bottom">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Display name</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value" id="displayNameValue"><%= displayName %></span>
                                        <div class="edit-field d-none">
                                            <input type="text" class="form-control" name="displayName" value="<%= displayName %>">
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button visible">Edit</button>
                                    </div>
                                </div>
                            </div>
                            <!-- Email -->
                            <div class="detail-row">
                                <div class="row align-items-center py-3 border-bottom">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Email address</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value" id="emailValue"><%= email %></span>
                                        <span class="badge bg-success ms-2">Verified</span>
                                        <div class="edit-field d-none">
                                            <input type="email" class="form-control" name="email" value="<%= email %>">
                                        </div>
                                        <small class="text-muted d-block">This is the email address you use to sign in.</small>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button visible">Edit</button>
                                    </div>
                                </div>
                            </div>
                            <!-- Phone -->
                            <div class="detail-row">
                                <div class="row align-items-center py-3 border-bottom">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Phone number</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value" id="phoneValue"><%= phone %></span>
                                        <div class="edit-field d-none">
                                            <input type="tel" class="form-control" name="phone" value="<%= phone.equals("Add your phone number") ? "" : phone %>">
                                        </div>
                                        <small class="text-muted d-block">Properties you book will use this number if they need to contact you.</small>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button visible">Edit</button>
                                    </div>
                                </div>
                            </div>
                            <!-- Date of Birth -->
                            <div class="detail-row">
                                <div class="row align-items-center py-3 border-bottom">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Date of birth</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value" id="dobValue">Enter your date of birth</span>
                                        <div class="edit-field d-none">
                                            <input type="date" class="form-control" name="dob">
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button visible">Edit</button>
                                    </div>
                                </div>
                            </div>
                            <!-- Gender -->
                            <div class="detail-row">
                                <div class="row align-items-center py-3 border-bottom">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Gender</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value" id="genderValue">Select your gender</span>
                                        <div class="edit-field d-none">
                                            <select class="form-select" name="gender">
                                                <option value="">Select gender</option>
                                                <option value="M">Male</option>
                                                <option value="F">Female</option>
                                                <option value="O">Other</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button visible">Edit</button>
                                    </div>
                                </div>
                            </div>
                            <!-- Address -->
                            <div class="detail-row">
                                <div class="row align-items-center py-3">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Address</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value" id="addressValue"><%= address %></span>
                                        <div class="edit-field d-none">
                                            <textarea class="form-control" name="address" rows="3"><%= address.equals("Add your address") ? "" : address %></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button visible">Edit</button>
                                    </div>
                                </div>
                            </div>
                            <div class="text-end mt-4">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light mt-5 py-3">
        <div class="container">
            <div class="text-center">
                <small class="text-muted">
                    © 2024 YourBooking.com™. All rights reserved.
                </small>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JavaScript -->
    <script src="js/script.js"></script>
</body>
</html>