StackableMethodMissing
========

This module makes your class allow for stackable method_missing filters.
You can add/remove filters (which are simply methods) from method_missing so that
multiple extensions/modules can use the same `method_missing` call instead of re-declaring it
and overwriting the other extensions/modules' usage of `method_missing`.

Usage
=====

* Include `stackable_method_missing` in your class
* Call `mm_prepend(:your_method_name)`
* Whenever `method_missing` is called, your methods'll be
* Remove with `mm_remove(:your_method_name)`
