class Array
  def to_rb_format
    self.map { |arr| arr.deep_transform_keys { |key| key.to_s.underscore.to_sym } }
  end

  def to_json_camelize
    self.map { |arr| arr.deep_transform_keys { |key| key.to_s.camelize(:lower) } }
  end

  def drop_last
    self[0...-1]
  end

  def to_obj
    JSON.parse(self.to_json, object_class: OpenStruct)
  end

  def to_hash_json
    JSON.parse(self.to_json, { symbolize_names: true } )
  end

  def with_indifferent_access
    map(&:with_indifferent_access)
  end
end
