class Entity
  include Comparable

  def <=>(other)
    identifier <=> other.identifier
  end

  def initialize(identifier)
    @identifier = identifier
  end

  attr_reader :identifier

  def to_s
    identifier.to_s
  end
end
