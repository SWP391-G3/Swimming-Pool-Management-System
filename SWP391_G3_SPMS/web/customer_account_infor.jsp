<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User user = (User) request.getAttribute("user");
    String updateSuccess = (String) request.getAttribute("updateSuccess");
    String updateError = (String) request.getAttribute("updateError");
    String dobValue = "";
    if (user != null && user.getDob() != null) {
        dobValue = new SimpleDateFormat("dd-MM-yyyy").format(user.getDob());
    }
    String avatarUrl = (user != null && user.getImages() != null && !user.getImages().isEmpty())
            ? user.getImages()
            : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxAA8303_86z01TPPqxwesKe7q_OJSJgWxvg&s";
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
        <style>
            .profile-picture-container {
                position: relative;
                display: inline-block;
                width: 120px;
                height: 120px;
                overflow: hidden;
            }
            .profile-picture-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                border-radius: 50%;
                display: block;
            }
            .profile-picture-upload {
                position: absolute;
                bottom: 0;
                right: 0;
                border-radius: 50%;
                background: #0071c2;
                color: #fff;
                border: none;
                width: 36px;
                height: 36px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                z-index: 3;
            }
            .profile-picture-upload input[type="file"] {
                display: none;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
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
                            <span class="ms-2"><%= user != null ? user.getFullName() : "[user null]" %></span>
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
                <!-- Sidebar -->
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
                <!-- Main content -->
                <div class="col-md-9">
                    <div class="card">
                        <div class="card-body">
                            <!-- Profile header -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2 class="card-title">Personal details</h2>
                                <div class="profile-picture-container">
                                    <img src="<%= avatarUrl %>" alt="Profile Picture" id="avatarPreview">
                                    <label class="profile-picture-upload" title="Change avatar">
                                        <i class="fas fa-camera"></i>
                                        <input type="file" name="images" accept="image/*" form="personalDetailsForm" onchange="previewAvatar(this)">
                                    </label>
                                </div>
                            </div>
                            <% if (updateSuccess != null && !updateSuccess.isEmpty()) { %>
                            <div class="alert alert-success" id="updateSuccessAlert"><%= updateSuccess %></div>
                            <% } %>
                            <p class="text-muted">Update your information and find out how it's used.</p>
                            <!-- Profile update form -->
                            <form id="personalDetailsForm" method="post" action="profile" autocomplete="off" enctype="multipart/form-data">
                                <input type="hidden" name="service" value="updateProfile"/>
                                <input type="hidden" name="id" value="<%= user != null ? user.getUserId() : "" %>"/>

                                <!-- Name -->
                                <div class="row align-items-center py-3 border-bottom detail-row">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Name</label>
                                    </div>
                                    <div class="col-md-7">
                                        <small class="text-muted d-block current-value">
                                            <%= (user != null && user.getFullName() != null && !user.getFullName().isEmpty()) ? user.getFullName() : "Add your name" %>
                                        </small>
                                        <div class="edit-field d-none">
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="full_name" value="<%= user != null ? user.getFullName() : "" %>">
                                                <button type="submit" class="btn btn-success btn-save-field" name="field" value="full_name" style="min-width:80px;">Save</button>
                                            </div>
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
                                        <small class="text-muted d-block current-value">
                                            <%= (user != null && user.getEmail() != null && !user.getEmail().isEmpty()) ? user.getEmail() : "This is the email address you use to sign in." %>
                                        </small>
                                        <div class="edit-field d-none">
                                            <div class="input-group">
                                                <input type="email" class="form-control" name="email" value="<%= user != null ? user.getEmail() : "" %>">
                                                <button type="submit" class="btn btn-success btn-save-field" name="field" value="email" style="min-width:80px;">Save</button>
                                            </div>
                                        </div>
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
                                        <small class="text-muted d-block current-value">
                                            <%
                                                String phoneDisplay = (user != null && user.getPhone() != null && !user.getPhone().isEmpty())
                                                        ? user.getPhone()
                                                        : "Properties you book will use this number if they need to contact you.";
                                            %>
                                            <%= phoneDisplay %>
                                        </small>
                                        <div class="edit-field d-none">
                                            <div class="input-group">
                                                <input type="tel" class="form-control" name="phone" value="<%= user != null ? user.getPhone() : "" %>">
                                                <button type="submit" class="btn btn-success btn-save-field" name="field" value="phone" style="min-width:80px;">Save</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button">Edit</button>
                                    </div>
                                </div>
                                <!-- DOB -->
                                <div class="row align-items-center py-3 border-bottom detail-row">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Date of Birth</label>
                                    </div>
                                    <div class="col-md-7">
                                        <small class="text-muted d-block current-value"><%= dobValue.isEmpty() ? "Add your dob" : dobValue %></small>
                                        <div class="edit-field d-none">
                                            <div class="input-group">
                                                <input type="date" class="form-control" name="dob" value="<%= user != null && user.getDob() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(user.getDob()) : "" %>">
                                                <button type="submit" class="btn btn-success btn-save-field" name="field" value="dob" style="min-width:80px;">Save</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button">Edit</button>
                                    </div>
                                </div>
                                <!-- Gender -->
                                <div class="row align-items-center py-3 border-bottom detail-row">
                                    <div class="col-md-3">
                                        <label class="form-label mb-0">Gender</label>
                                    </div>
                                    <div class="col-md-7">
                                        <small class="text-muted d-block current-value"><%= user != null && user.getGender() != null && !user.getGender().isEmpty() ? user.getGender() : "Add your gender" %></small>
                                        <div class="edit-field d-none">
                                            <div class="input-group">
                                                <select class="form-control" name="gender">
                                                    <option value="">Select gender</option>
                                                    <option value="Male" <%= user != null && "Male".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Male</option>
                                                    <option value="Female" <%= user != null && "Female".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Female</option>
                                                    <option value="Other" <%= user != null && "Other".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Other</option>
                                                </select>
                                                <button type="submit" class="btn btn-success btn-save-field" name="field" value="gender" style="min-width:80px;">Save</button>
                                            </div>
                                        </div>
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
                                        <small class="text-muted d-block current-value">
                                            <%= (user != null && user.getAddress() != null && !user.getAddress().isEmpty()) ? user.getAddress() : "Add your address" %>
                                        </small>
                                        <div class="edit-field d-none">
                                            <div class="input-group">
                                                <textarea class="form-control" name="address" rows="3"><%= user != null ? user.getAddress() : "" %></textarea>
                                                <button type="submit" class="btn btn-success btn-save-field" name="field" value="address" style="min-width:80px;">Save</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-end">
                                        <button type="button" class="btn btn-link edit-button">Edit</button>
                                    </div>
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
                        © 2025 PoolHub™. All rights reserved.
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
                                                var editButtons = document.querySelectorAll('.edit-button');
                                                editButtons.forEach(function (btn) {
                                                    btn.addEventListener('click', function () {
                                                        var parentRow = btn.closest('.row');
                                                        parentRow.querySelector('.current-value').classList.add('d-none');
                                                        parentRow.querySelector('.edit-field').classList.remove('d-none');
                                                        btn.classList.add('d-none');
                                                    });
                                                });

                                                var saveButtons = document.querySelectorAll('.btn-save-field');
                                                saveButtons.forEach(function (btn) {
                                                    btn.addEventListener('click', function () {
                                                    });
                                                });
                                            });

                                            function previewAvatar(input) {
                                                if (input.files && input.files[0]) {
                                                    var reader = new FileReader();
                                                    reader.onload = function (e) {
                                                        document.getElementById('avatarPreview').src = e.target.result;
                                                    };
                                                    reader.readAsDataURL(input.files[0]);
                                                }
                                            }
        </script>
    </body>
</html>

//kiên lê
