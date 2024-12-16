require "./dor/entity"

class Monograph < Entity
  def monograph
    self
  end

  def to_s
    "#{identifier} []"
  end
end
