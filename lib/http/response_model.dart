class ResponseModel<T> {
  T? content;
  int? code;
  String? message;
  bool? success;

  // ResponseModel({
  //   required this.success,
  //   required this.message,
  //   required this.content,
  //   required this.code,
  // });

  // T? get data => content;
  //
  // set data(T? value) {
  //   content = value;
  // }

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    content = json['data'];
  }

  // factory ResponseModel.fromJson(Map<String, dynamic> json) {
  //   return ResponseModel(
  //     success: json['success'],
  //     message: json['message'],
  //     data: json['data'],
  //   );
  // }

  @override
  String toString() {
    return "{success: $success, message: $message, content: $content, code: $code}";
  }
}
