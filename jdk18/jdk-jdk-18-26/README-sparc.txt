Changes in 18+23

In c1_LIRAssembler_sparc.cpp, a new function
LIR_Assembler::emit_load_klass()
which is a chunk of code pulled from elsewhere, although it's not
actually obvious where as there's so much variation in the different
cpus. Actually, ppc looks like the closest match here in terms of
where the original code was (in LIR_Assembler::load()).

So, the code

+      case T_ADDRESS:
+        if (offset == oopDesc::klass_offset_in_bytes() && UseCompressedClassPointers) {
+          __ lduw(base, offset, to_reg->as_register());
+          __ decode_klass_not_null(to_reg->as_register());
+        } else
+        {
+          __ ld_ptr(base, offset, to_reg->as_register());
+        }
+        break;

becomes

+      case T_ADDRESS:
+        __ ld_ptr(base, offset, to_reg->as_register());
+        break;

and the new function is

note:
to_reg->as_register() ==> result
offset ==> oopDesc::klass_offset_in_bytes()
base ==> obj

+void LIR_Assembler::emit_load_klass(LIR_OpLoadKlass* op) {
+  Register obj = op->obj()->as_pointer_register();
+  Register result = op->result_opr()->as_pointer_register();
+
+  CodeEmitInfo* info = op->info();
+  if (info != NULL) {
+    add_debug_info_for_null_check_here(info);
+  }
+
+  if (UseCompressedClassPointers) {
+    __ lduw(obj, oopDesc::klass_offset_in_bytes(), result);
+    __ decode_klass_not_null(result);
+  } else {
+    __ ld_ptr(obj, oopDesc::klass_offset_in_bytes(), result);
+  }
+}
