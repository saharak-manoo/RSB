class String
  def to_number
    return if self.blank?

    (self.to_f % 1) > 0 ? self.to_f : self.to_i
  end

  def number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end

  def to_rb_obj
    JSON.parse(self, object_class: OpenStruct)
  end
end