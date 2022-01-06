class Numeric
  def non_negative
    self > 0 ? self : 0
  end

  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end
