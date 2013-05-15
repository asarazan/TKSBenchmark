TKSBenchmark
============

A quick and dirty benchmark of mutex-based sync dictionaries vs dispatch-driven ones.

* **CueSyncDictionary**: NSMutableDictionary + std::mutex
* **DispatchDictionary**: NSMutableDictionary + dispatch queue (with barrier for setObject:forKey:)

### My Results (run in the simulator on a MBP i5 dual core 2.5GHz)
_presented without comment or analysis_

### 4 readers, 0 writers
* [4R:0W] CueSyncDictionary Finished 5000000 reads and 0 writes in 7.464663 seconds
* [4R:0W] DispatchDictionary Finished 5000000 reads and 0 writes in 11.290138 seconds
* [4R:0W] CueSyncDictionary Finished 5000000 reads and 0 writes in 7.332433 seconds
* [4R:0W] DispatchDictionary Finished 5000000 reads and 0 writes in 9.980433 seconds

### 0 readers, 4 writers
* [0R:4W] CueSyncDictionary Finished 0 reads and 5000000 writes in 15.366588 seconds
* [0R:4W] DispatchDictionary Finished 0 reads and 5000000 writes in 17.695334 seconds
* [0R:4W] CueSyncDictionary Finished 0 reads and 5000000 writes in 15.507622 seconds
* [0R:4W] DispatchDictionary Finished 0 reads and 5000000 writes in 17.678778 seconds

### 2 readers, 2 writers
* [2R:2W] CueSyncDictionary Finished 2500000 reads and 2500000 writes in 8.861671 seconds
* [2R:2W] DispatchDictionary Finished 2500000 reads and 2500000 writes in 9.735245 seconds
* [2R:2W] CueSyncDictionary Finished 2500000 reads and 2500000 writes in 8.145304 seconds
* [2R:2W] DispatchDictionary Finished 2500000 reads and 2500000 writes in 11.332466 seconds

### 2 readers, 1 writer
* [2R:1W] CueSyncDictionary Finished 2500000 reads and 2500000 writes in 7.464192 seconds
* [2R:1W] DispatchDictionary Finished 2500000 reads and 2500000 writes in 9.334130 seconds
* [2R:1W] CueSyncDictionary Finished 2500000 reads and 2500000 writes in 7.958390 seconds
* [2R:1W] DispatchDictionary Finished 2500000 reads and 2500000 writes in 10.082576 seconds
