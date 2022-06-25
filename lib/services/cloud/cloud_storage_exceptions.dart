class CloudStorageException implements Exception {
  const CloudStorageException();
}

// Create Complaint
class CouldNotCreateComplaintException extends CloudStorageException {}

// Read Complaint
class CouldNotGetAllComplaintException extends CloudStorageException {}

// Update Complaint
class CouldNotUpdateComplaintException extends CloudStorageException {}

// Delete Complaint
class CouldNotDeleteComplaintException extends CloudStorageException {}
