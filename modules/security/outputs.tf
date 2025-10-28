# output "security_group_id" {
#     description = "id for security group"
#     value = aws_security_group.sg.id
# }

output "security_group_id" {
    value = aws_security_group.sg.id
}