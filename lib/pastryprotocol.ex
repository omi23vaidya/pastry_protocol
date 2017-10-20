defmodule PastryProtocol do

  def main(input) do
    [numNodes, numRequests] = input
    numNodes = String.to_integer(numNodes)
    numRequests = String.to_integer(numRequests)
    IO.puts "Nodes   : #{numNodes}"
    IO.puts "Requests: #{numRequests}"
    nodeList = start(numNodes, [], [])
  end

  def start(numNodes, nodeList, pidList) when numNodes > 0 do
    newNode = :crypto.hash(:md5, Integer.to_string(numNodes)) |> Base.encode16()
    newPid = spawn(PNode, :init, [newNode])
    nodeList = nodeList ++ [newNode]
    pidList = pidList ++ [newPid]
    start(numNodes-1, nodeList, pidList)
  end

  def start(numNodes, nodeList, pidList) when numNodes <= 0 do
    [nodeList, pidList]
  end

end
