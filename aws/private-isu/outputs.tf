output "server_ip" {
  value       = aws_eip.server.public_ip
  description = "private-isu サーバーの EIP"
}

output "benchmarker_ip" {
  value       = aws_eip.benchmarker.public_ip
  description = "private-isu ベンチマーカーの EIP"
}
