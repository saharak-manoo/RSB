class Json
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
end
