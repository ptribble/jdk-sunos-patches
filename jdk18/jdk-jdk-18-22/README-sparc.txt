Changes in 18+22

In sparc.ad, add
+  match(StoreStoreFence);
to membar_storestore(), to match all the other cpus.
