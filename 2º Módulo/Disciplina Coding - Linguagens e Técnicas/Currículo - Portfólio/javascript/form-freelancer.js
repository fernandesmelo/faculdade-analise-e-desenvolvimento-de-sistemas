document.getElementById('projectForm').addEventListener('submit', function(event) {
    event.preventDefault(); 
    
    var successModal = new bootstrap.Modal(document.getElementById('successModal'));
    successModal.show();
});