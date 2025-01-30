$NetBSD$

Similar issue to https://bugs.openjdk.org/browse/JDK-8193056

--- src/hotspot/share/gc/g1/g1Analytics.cpp.orig	2019-01-08 12:44:56.000000000 +0000
+++ src/hotspot/share/gc/g1/g1Analytics.cpp
@@ -22,6 +22,7 @@
  *
  */
 
+#include "memory/allocation.inline.hpp"
 #include "gc/g1/g1Analytics.hpp"
 #include "gc/g1/g1AnalyticsSequences.inline.hpp"
 #include "gc/g1/g1Predictions.hpp"
