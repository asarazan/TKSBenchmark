TKSBenchmark
============

A quick and dirty benchmark of mutex-based sync dictionaries vs dispatch-driven ones. 
The scientific method is in short supply here, so if you'd like to see different/better metrics, pull request!

* **CueSyncDictionary**: NSMutableDictionary + std::mutex
* **DispatchDictionary**: NSMutableDictionary + dispatch queue (with barrier for setObject:forKey:)

### My Results (run in the simulator on a MBP i5 dual core 2.5GHz)
_presented without comment or analysis_

### 4 readers, 0 writers
* [4R:0W] CueSyncDictionary Finished 800000 reads and 0 writes in 5.011347 seconds
* [4R:0W] DispatchDictionary Finished 800000 reads and 0 writes in 0.632817 seconds
* [4R:0W] CueSyncDictionary Finished 800000 reads and 0 writes in 4.371315 seconds
* [4R:0W] DispatchDictionary Finished 800000 reads and 0 writes in 0.550628 seconds

### 0 readers, 4 writers
* [0R:4W] CueSyncDictionary Finished 0 reads and 800000 writes in 4.702511 seconds
* [0R:4W] DispatchDictionary Finished 0 reads and 800000 writes in 4.692594 seconds
* [0R:4W] CueSyncDictionary Finished 0 reads and 800000 writes in 4.546342 seconds
* [0R:4W] DispatchDictionary Finished 0 reads and 800000 writes in 4.750943 seconds

### 2 readers, 2 writers
* [2R:2W] CueSyncDictionary Finished 400000 reads and 400000 writes in 4.478745 seconds
* [2R:2W] DispatchDictionary Finished 400000 reads and 400000 writes in 7.835323 seconds
* [2R:2W] CueSyncDictionary Finished 400000 reads and 400000 writes in 4.092932 seconds
* [2R:2W] DispatchDictionary Finished 400000 reads and 400000 writes in 7.685819 seconds

### 2 readers, 1 writer
* [2R:1W] CueSyncDictionary Finished 400000 reads and 400000 writes in 3.690147 seconds
* [2R:1W] DispatchDictionary Finished 400000 reads and 400000 writes in 5.287899 seconds
* [2R:1W] CueSyncDictionary Finished 400000 reads and 400000 writes in 3.470804 seconds
* [2R:1W] DispatchDictionary Finished 400000 reads and 400000 writes in 5.176615 seconds
