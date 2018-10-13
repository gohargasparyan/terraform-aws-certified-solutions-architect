# HR

resource "aws_iam_group" "HR" {
  name = "HR"
}

resource "aws_iam_policy_attachment" "s3-readonly-attachment" {
  name       = "s3-readonly-attachment"
  groups     = ["${aws_iam_group.HR.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_user" "john" {
  name = "john"
}

resource "aws_iam_policy_attachment" "glacier-readonly-attachment" {
  name       = "glacier-readonly-attachment"
  users     = ["${aws_iam_user.john.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonGlacierReadOnlyAccess"
}

resource "aws_iam_policy_attachment" "IAMUserChangePassword-attachment" {
  name       = "IAMUserChangePassword-attachment"
  users     = ["${aws_iam_user.john.name}"]
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

resource "aws_iam_group_membership" "HR-membership" {
  name = "HR-membership"

  users = [
    "${aws_iam_user.john.name}"
  ]

  group = "${aws_iam_group.HR.name}"
}


# System-admin

resource "aws_iam_group" "System-Admin" {
  name = "System-Admin"
}

resource "aws_iam_policy_attachment" "admin-attachment" {
  name       = "admin-attachment"
  groups     = ["${aws_iam_group.System-Admin.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "ryan" {
  name = "ryan"
}

resource "aws_iam_group_membership" "Admin-membership" {
  name = "Admin-membership"

  users = [
    "${aws_iam_user.ryan.name}"
  ]

  group = "${aws_iam_group.System-Admin.name}"
}
