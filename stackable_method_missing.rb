#
# StackableMethodMissing
# ========
#
# This module makes your class allow for stackable method_missing filters.
# You can add/remove filters (which are simply methods) from method_missing so that
# multiple extensions/modules can use the same `method_missing` call instead of re-declaring it
# and overwriting the other extensions/modules' usage of `method_missing`.
#
require 'rubygems'
require 'active_support/all'

module StackableMethodMissing
  include ActiveSupport
  
  mattr_accessor :_stack
  
  # Redefined, so it's important to list StackableMethodMissing as the final include.
  def method_missing(*args)
    self._stack.each do |method_or_block|
      self.send method_or_block if method_or_block.is_a?(String) or method_or_block.is_a?(Symbol)
      method_or_block.call if method_or_block.is_a?(Proc)
    end
  end
  
  def mm_add_or_remove(add_or_remove, method_name)
    self._stack = [] if self._stack.nil?
    if add_or_remove == :remove
      # Remove
      self._stack.delete method_name
    else
      # Add
      self._stack.push method_name
    end
  end
  
  # Shortcuts
  def mm_remove(method_name_or_block)
    mm_add_or_remove(:remove, method_name_or_block)
  end
  
  def mm_prepend(method_name_or_block)
    mm_add_or_remove(:prepend, method_name_or_block)
  end
  
  def mm_append(method_name_or_block)
    mm_add_or_remove(:append, method_name_or_block)
  end
  
end
