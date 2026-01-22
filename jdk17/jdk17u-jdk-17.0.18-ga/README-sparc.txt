The TemplateTable::ldc() signature has changed from
  TemplateTable::ldc(bool wide)
to
  TemplateTable::ldc(LdcType type)
and likewise for TemplateTable::fast_aldc(). And rather than checking
for wide, use is_ldc_wide(type).
