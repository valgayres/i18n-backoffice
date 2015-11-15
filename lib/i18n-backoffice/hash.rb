require 'active_support/core_ext/hash'

class Hash
  def get_locales!
    slice!(*I18n.available_locales)
  end

  def get_locales
    slice(*I18n.available_locales)
  end

  def deep_flatten_by_stringification!(previous_keys = [])
    keys.each do |key|
      new_keys_list = previous_keys + [key]
      value = delete(key)
      if value.is_a?(Hash)
        merge!(value.deep_flatten_by_stringification!(new_keys_list))
      else
        self[new_keys_list.join('.')] = value
      end
    end
    self
  end

  def deep_flatten_by_stringification(previous_keys = [])
    result = {}
    each do |key, value|
      new_keys_list = previous_keys + [key]
      if value.is_a?(Hash)
        result.merge!(value.deep_flatten_by_stringification(new_keys_list))
      else
        result[new_keys_list.join('.')] = value
      end
    end
    result
  end

  def dig_hashed_by_spliting_keys!
    keys.each do |key|
      next if key.class == Symbol
      next if key.empty?
      value = delete(key)
      key_list = key.split('.')
      if key_list.length == 1
        deep_merge!(key_list[0].to_sym => value)
      else
        deep_merge!(key_list.shift.to_sym => {key_list.join('.') => value}.dig_hashed_by_spliting_keys!)
      end
    end
    self
  end

  def dig_hashed_by_spliting_keys
    result = {}
    each do |key, value|
      result[key] = value if key.class == Symbol
      next if key.empty?
      key_list = key.split('.')
      if key_list.length == 1
        result.deep_merge!(key_list[0].to_sym => value)
      else
        result.deep_merge!(key_list.shift.to_sym => {key_list.join('.') => value}.dig_hashed_by_spliting_keys)
      end
    end
    result
  end

  def deep_sort_by_keys!
    keys.sort.each do |key|
      value = delete(key)
      merge!(key => value.is_a?(Hash) ? value.deep_sort_by_keys! : value)
    end
    self
  end

  def deep_sort_by_keys
    result = {}
    sort_by {|k,v| k}.each do |key, value|
      if value.is_a?(Hash)
        result[key] = value.deep_sort_by_keys
      else
        result[key] = value
      end
    end
    result
  end
end