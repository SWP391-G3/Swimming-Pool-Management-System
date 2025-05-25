document.addEventListener('DOMContentLoaded', function () {
    // Handle edit buttons
    document.querySelectorAll('.edit-button').forEach(button => {
        button.addEventListener('click', function (e) {
            const row = this.closest('.detail-row');
            const currentValue = row.querySelector('.current-value');
            const editField = row.querySelector('.edit-field');
            const input = editField.querySelector('input, select, textarea');

            if (editField.classList.contains('d-none')) {
                // Switch to edit mode
                currentValue.classList.add('d-none');
                editField.classList.remove('d-none');
                this.textContent = 'Save';

                // Set current value to input
                if (currentValue.textContent !== 'Choose a display name' &&
                        currentValue.textContent !== 'Add your phone number' &&
                        currentValue.textContent !== 'Enter your date of birth' &&
                        currentValue.textContent !== 'Select your nationality' &&
                        currentValue.textContent !== 'Select your gender' &&
                        currentValue.textContent !== 'Add your address' &&
                        currentValue.textContent !== 'Not provided') {
                    input.value = currentValue.textContent;
                }
                input.focus();
            } else {
                // Save changes
                if (validateField(input)) {
                    currentValue.textContent = input.value;
                    currentValue.classList.remove('d-none');
                    editField.classList.add('d-none');
                    this.textContent = 'Edit';

                    // Show success message
                    showMessage('Changes saved successfully!', 'success');
                    saveChanges(input.name, input.value);
                }
            }
        });
    });

    // Field validation
    function validateField(input) {
        let isValid = true;
        const name = input.name;
        const value = input.value.trim();

        switch (name) {
            case 'email':
                isValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
                if (!isValid)
                    showMessage('Please enter a valid email address', 'error');
                break;
            case 'phone':
                isValid = /^\+?[\d\s-]{10,}$/.test(value);
                if (!isValid)
                    showMessage('Please enter a valid phone number', 'error');
                break;
            case 'name':
                isValid = value.length >= 2;
                if (!isValid)
                    showMessage('Name must be at least 2 characters long', 'error');
                break;
            case 'dob':
                isValid = value !== '';
                if (!isValid)
                    showMessage('Please select your date of birth', 'error');
                break;
            case 'nationality':
            case 'gender':
                isValid = value !== '';
                if (!isValid)
                    showMessage('Please make a selection', 'error');
                break;
            default:
                isValid = value !== '';
                if (!isValid)
                    showMessage('This field cannot be empty', 'error');
        }

        if (!isValid) {
            input.classList.add('is-invalid');
            return false;
        }

        input.classList.remove('is-invalid');
        return true;
    }

    // Save changes function (mock implementation)
    function saveChanges(field, value) {
        console.log(`Saving ${field}: ${value}`);
    }

    // Show message function
    function showMessage(message, type) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type === 'success' ? 'success' : 'danger'} alert-dismissible fade show position-fixed top-0 start-50 translate-middle-x mt-3`;
        alertDiv.style.zIndex = '1050';
        alertDiv.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        `;
        document.body.appendChild(alertDiv);

        // Auto remove after 3 seconds
        setTimeout(() => {
            alertDiv.remove();
        }, 3000);
    }

    // Add passport button handler
    const addPassportButton = document.querySelector('.btn-primary');
    if (addPassportButton) {
        addPassportButton.addEventListener('click', function () {
            const row = this.closest('.detail-row');
            const currentValue = row.querySelector('.current-value');
            const editField = row.querySelector('.edit-field');

            if (editField.classList.contains('d-none')) {
                currentValue.classList.add('d-none');
                editField.classList.remove('d-none');
                this.textContent = 'Save passport';
            } else {
                const input = editField.querySelector('input');
                if (validateField(input)) {
                    currentValue.textContent = input.value;
                    currentValue.classList.remove('d-none');
                    editField.classList.add('d-none');
                    this.textContent = 'Add passport';
                    showMessage('Passport details saved successfully!', 'success');
                    saveChanges('passport', input.value);
                }
            }
        });
    }
});
