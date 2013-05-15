TKSBenchmark
============

A quick and dirty benchmark of mutex-based sync dictionaries vs dispatch-driven ones. 
The scientific method is in short supply here, so if you'd like to see different/better metrics, pull request!

* **CueSyncDictionary**: NSMutableDictionary + std::mutex
* **DispatchDictionary**: NSMutableDictionary + dispatch queue (with barrier for setObject:forKey:)

### My Results (run in the simulator on a MBP i5 dual core 2.5GHz)
_presented without comment or analysis_

### 4 readers, 0 writers
* [4R:0W] CueSyncDictionary Finished 800000 reads and 0 writes in 4.066146 seconds
* [4R:0W] DispatchDictionary Finished 800000 reads and 0 writes in 3.639828 seconds
* [4R:0W] CueSyncDictionary Finished 800000 reads and 0 writes in 4.229840 seconds
* [4R:0W] DispatchDictionary Finished 800000 reads and 0 writes in 3.682911 seconds

### 0 readers, 4 writers
* [0R:4W] CueSyncDictionary Finished 0 reads and 800000 writes in 5.477869 seconds
* [0R:4W] DispatchDictionary Finished 0 reads and 800000 writes in 5.125106 seconds
* [0R:4W] CueSyncDictionary Finished 0 reads and 800000 writes in 5.146630 seconds
* [0R:4W] DispatchDictionary Finished 0 reads and 800000 writes in 4.995340 seconds

### 2 readers, 2 writers
* [2R:2W] CueSyncDictionary Finished 400000 reads and 400000 writes in 4.421995 seconds
* [2R:2W] DispatchDictionary Finished 400000 reads and 400000 writes in 4.162217 seconds
* [2R:2W] CueSyncDictionary Finished 400000 reads and 400000 writes in 4.473137 seconds
* [2R:2W] DispatchDictionary Finished 400000 reads and 400000 writes in 4.222003 seconds

### 2 readers, 1 writer
* [2R:1W] CueSyncDictionary Finished 400000 reads and 400000 writes in 3.867335 seconds
* [2R:1W] DispatchDictionary Finished 400000 reads and 400000 writes in 3.809772 seconds
* [2R:1W] CueSyncDictionary Finished 400000 reads and 400000 writes in 3.715670 seconds
* [2R:1W] DispatchDictionary Finished 400000 reads and 400000 writes in 3.511200 seconds
