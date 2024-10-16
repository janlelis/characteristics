## CHANGELOG

### 1.7.1

* Fixes in README and GEMSPEC
* Remove "U+110B1 Kaithi Vowel Sign I" from blanks

### 1.7.0

* Unicode 16.0 (general categories)

### 1.6.0

* Unicode 15.1 (general categories)

### 1.5.0

* Unicode 15 (general categories)

### 1.4.1

* Add NO-BREAK SPACE to blanks 😅

### 1.4.0

* Unicode 14 (general categories)

### 1.3.0

* Unicode 13 (general categories)
* Relax Ruby version requirement to allow Ruby 3.0

### 1.2.0

* Unicode 12 (general categories)

### 1.1.0

* Unicode 11 (general categories)

### 1.0.0

* Mark as production-ready, no API changes

### 0.8.0

* Unicode 10 (general categories)

### 0.7.0

* Add more Unicode properties
  * variation_selector?
  * tag?
  * ignorable?
  * noncharacter?

### 0.6.0

* Add separator? property
* Ensure all characteristics have a c0? / c1? method
* Add GB1988 encoding (which is a 7bit ascii-like)

### 0.5.2

* Add another Hangul blank (U+FFA0)

### 0.5.1

* (Proper version of gem on rubygems.org)

### 0.5.0

* Add bidi_control? property
* Treat NEL (in C1 area) as separator
* Treat RLM and LRM as blanks
* Treat CGJ as blank

### 0.4.0

* Support Japanese Emojis (KDDI / SoftBank / DoCoMo) for Unicode

### 0.3.1

* Add two Khmer blanks (U+17B4, U+17B5)
* Add one Kaithi blank (U+110B1)
* Add one Syriac blank (U+070F)
* Add one Arabic blank (U+061C)
* Make general category readable for UnicodeCharacteristics

### 0.3.0

* Add soft-hyphen to single byte encodings
* Add format? property (e.g. RLM)
* Support more encodings: IBMX, CP85X, macX, TIS-620, Windows-874, KOI8-X

### 0.2.0

* Fix detection of supported Windows encodings and some unassigned codepoints
* Include unassigned codepoints of ISO-8859-X

### 0.1.0

* Initial release

