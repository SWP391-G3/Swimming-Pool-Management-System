<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User" %>
<%
    User user = (User) request.getAttribute("user");
    String updateSuccess = (String) request.getAttribute("updateSuccess");
    String updateError = (String) request.getAttribute("updateError");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile - PoolHub</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="#">PoolHub</a>
                <div class="d-flex align-items-center">
                    <button class="btn btn-link text-white">
                        <i class="fas fa-question-circle"></i>
                    </button>
                    <div class="dropdown">
                        <button class="btn btn-link text-white dropdown-toggle" type="button" id="userMenu" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i>
                            <span class="ms-2"><%= user != null ? user.getUsername() : "[user null]" %></span>
                        </button>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container my-4">
            <% if (updateError != null && !updateError.isEmpty()) { %>
            <div class="alert alert-danger"><%= updateError %></div>
            <% } %>
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <a href="profile" class="list-group-item list-group-item-action active">
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
                <div class="col-md-9">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2 class="card-title">Personal details</h2>
                                <div class="position-relative">
                                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxAA8303_86z01TPPqxwesKe7q_OJSJgWxvg&s" class="rounded-circle" alt="Profile Picture">
                                    <button class="btn btn-sm btn-primary position-absolute bottom-0 end-0" style="border-radius: 50%;">
                                        <i class="fas fa-camera"></i>
                                    </button>
                                </div>
                            </div>
                            <% if (updateSuccess != null && !updateSuccess.isEmpty()) { %>
                            <div class="alert alert-success" id="updateSuccessAlert"><%= updateSuccess %></div>
                            <% } %>
                            <p class="text-muted">Update your information and find out how it's used.</p>
                            <form id="personalDetailsForm" method="post" action="profile" autocomplete="off">
                                <input type="hidden" name="service" value="updateProfile"/>
                                <input type="hidden" name="id" value="<%= user != null ? user.getUser_id() : "" %>"/>

                                <!-- Name -->
                                <div class="row align-items-center py-3 border-bottom detail-row">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Name</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value"><%= user != null ? user.getFull_name() : "[user null]" %></span>
                                        <div class="edit-field d-none">
                                            <input type="text" class="form-control" name="full_name" value="<%= user != null ? user.getFull_name() : "" %>">
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button">Edit</button>
                                    </div>
                                </div>
                                <!-- Email -->
                                <div class="row align-items-center py-3 border-bottom detail-row">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Email address</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value"><%= user != null ? user.getEmail() : "[user null]" %></span>
                                        <div class="edit-field d-none">
                                            <input type="email" class="form-control" name="email" value="<%= user != null ? user.getEmail() : "" %>">
                                        </div>
                                        <small class="text-muted d-block">This is the email address you use to sign in.</small>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button">Edit</button>
                                    </div>
                                </div>
                                <!-- Phone -->
                                <div class="row align-items-center py-3 border-bottom detail-row">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Phone number</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value">
                                            <%= (user != null && (user.getPhone() == null || user.getPhone().isEmpty())) ? "Add your phone number" : (user != null ? user.getPhone() : "[user null]") %>
                                        </span>
                                        <div class="edit-field d-none">
                                            <input type="tel" class="form-control" name="phone" value="<%= user != null ? user.getPhone() : "" %>">
                                        </div>
                                        <small class="text-muted d-block">Properties you book will use this number if they need to contact you.</small>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button">Edit</button>
                                    </div>
                                </div>
                                <!-- Address -->
                                <div class="row align-items-center py-3 detail-row">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Address</label>
                                    </div>
                                    <div class="col-md-7">
                                        <span class="current-value">
                                            <%= (user != null && (user.getAddress() == null || user.getAddress().isEmpty())) ? "Add your address" : (user != null ? user.getAddress() : "[user null]") %>
                                        </span>
                                        <div class="edit-field d-none">
                                            <textarea class="form-control" name="address" rows="3"><%= user != null ? user.getAddress() : "" %></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button">Edit</button>
                                    </div>
                                </div>
                                <div class="text-end mt-3">
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="bg-light mt-3 py-3">
            <div class="container">
                <div class="text-center">
                    <small class="text-muted">
                        © 2024 PoolHub™. All rights reserved.
                    </small>
                </div>
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var alert = document.getElementById("updateSuccessAlert");
                if (alert) {
                    setTimeout(function () {
                        alert.style.display = "none";
                    }, 5000);
                }
                // Script cho nút Edit
                var editButtons = document.querySelectorAll('.edit-button');
                editButtons.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        var parentRow = btn.closest('.row');
                        parentRow.querySelector('.current-value').classList.add('d-none');
                        parentRow.querySelector('.edit-field').classList.remove('d-none');
                        btn.classList.add('d-none');
                    });
                });
            });
        </script>
    </body>
</html>