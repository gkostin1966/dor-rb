class Entity
  include Comparable

  def <=>(other)
    identifier <=> other.identifier
  end

  def initialize(identifier)
    @identifier = identifier
  end

  attr_reader :identifier
end
