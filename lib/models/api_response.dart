// Define a generic response model
class ApiResponse<T> {
  final String apiVersion;
  final String organizationName;
  final String message;
  final bool success;
  final int status;
  final T data; // Generic data field

  ApiResponse({
    required this.apiVersion,
    required this.organizationName,
    required this.message,
    required this.success,
    required this.status,
    required this.data,
  });

  // Factory method to create an instance of ApiResponse from JSON
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse<T>(
      apiVersion: json['apiVersion'],
      organizationName: json['organizationName'],
      message: json['message'],
      success: json['success'],
      status: json['status'],
      data: fromJsonT(json[
          'data']), // Use the provided function to convert 'data' to the generic type
    );
  }
}
