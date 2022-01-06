class NilClass
  def to_not_blank
    self.nil? ? " " : self
  end
end
