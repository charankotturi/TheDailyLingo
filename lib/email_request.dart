class EmailRequest{
  String email;
  String subject;
  String message;

  EmailRequest({required this.email, this.subject="", this.message = ""});

  factory EmailRequest.fromJson(Map<String, dynamic> json) {
    return EmailRequest(
      email: json['email'],
      subject: json['subject'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'subject': subject,
    'message': message,
  };
}