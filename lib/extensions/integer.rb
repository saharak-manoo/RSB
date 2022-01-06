class Integer
  def to_delimited
    ActiveSupport::NumberHelper.number_to_delimited(self)
  end

  def non_negative
    self.negative? ? 0 : self
  end

  def number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end
