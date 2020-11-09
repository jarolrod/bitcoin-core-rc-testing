# 1. node index, 2. rpc string
run_rpc() {
  # Compose complete rpc command string
  rpc_string="${BITCOINCLI[$1]} $2"
  ./bin/${rpc_string}
}
