
resource "local_file" "hello_file" {
  filename = "${path.root}/hello.txt"
  content  = var.file_content
}