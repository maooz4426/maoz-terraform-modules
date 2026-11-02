output "server_public_ip" {
  value       = aws_eip.isucon14_server.public_ip
  description = "isucon14 サーバーの EIP"
}

output "benchmarker_public_ip" {
  value       = aws_eip.isucon14_benchmarker.public_ip
  description = "isucon14 ベンチマーカーの EIP"
}
