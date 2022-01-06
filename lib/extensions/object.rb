class Object
  def number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end

  def to_rb_obj
    JSON.parse(self, object_class: OpenStruct)
  end
end