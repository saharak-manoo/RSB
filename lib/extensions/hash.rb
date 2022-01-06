class Hash
  def to_rb_format
    self.deep_transform_keys { |key| key.to_s.underscore.to_sym }
  end

  def to_json_camelize
    self.deep_transform_keys { |key| key.to_s.camelize(:lower) }
  end

  def to_pretty
    JSON.pretty_generate(self)
  end

  def to_obj
    JSON.parse(self.to_json, object_class: OpenStruct)
  end

  def to_hash_json
    JSON.parse(self.to_json, { symbolize_names: true } )
  end

  def transform_hash
    new_hash = {}
    self.each do |key, val|
      new_key, new_sub_key = key.to_s.split('.')
      new_key = new_key.to_sym
      if new_sub_key.present?
        new_sub_key = new_sub_key.to_sym
        new_hash[new_key] = {} if new_hash[new_key].nil?
        new_hash[new_key].merge!({ new_sub_key => val })
      else
        new_hash.store(key, val)
      end
    end

    new_hash
  end
end
