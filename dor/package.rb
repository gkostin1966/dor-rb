class Package
  include Comparable

  def <=>(other)
    identifier <=> other.identifier
  end

  def initialize(identifier)
    @identifier = identifier
  end

  def add_entity(entity)
    entities << entity
  end

  def entities
    @entities ||= []
  end

  attr_reader :identifier
end
