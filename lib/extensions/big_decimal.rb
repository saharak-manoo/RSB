class BigDecimal
  def to_delimited
    ActiveSupport::NumberHelper.number_to_delimited(self)
  end

  def nil_or_zero?
    (self.nil? or self == 0)
  end

  def number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end
