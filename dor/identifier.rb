class Identifier
  include Comparable

  def <=>(other)
    name <=> other.name
  end

  def initialize(name)
    @name = name
  end

  attr_reader :name
end
