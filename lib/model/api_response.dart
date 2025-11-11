class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data; // <─ can be User, List<User>, DashboardModel …

  ApiResponse({required this.success, required this.message, this.data});

  /* factory that receives a *converter* for the inner payload */
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT, // <-- pass how to parse data
  ) => ApiResponse<T>(
    success: json['success'],
    message: json['message'],
    data: json['data'] == null ? null : fromJsonT(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data,
  };

  @override
  String toString() =>
      'ApiResponse(success:$success, message:$message, data:$data)';
}
