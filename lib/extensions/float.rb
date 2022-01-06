class Float
  def to_delimited
    ActiveSupport::NumberHelper.number_to_delimited(self)
  end

  def nil_or_zero?
    (self.nil? or self == 0)
  end

  def to_translate
    self.to_i.zero? ? I18n.t("free") : "#{self.to_delimited} / #{I18n.t("month")}"
  end

  def non_negative
    self.negative? ? 0 : self
  end

  def number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end
