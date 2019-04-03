extends Node

func export(graph_data):
    var binary_result = PoolByteArray()
    binary_result.append(72)
    binary_result.append(101)
    binary_result.append(108)
    binary_result.append(108)
    binary_result.append(111)
    return binary_result

