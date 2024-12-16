class Package
  include Comparable

  def <=>(other)
    identifier <=> other.identifier
  end

  def initialize(identifier)
    @identifier = identifier
    @monograph = nil
    @scanned_pages = []
    @ocr = []
    @metadata = {}
  end

  def add(entity)
    entities << entity
  end

  def add_entity(entity)
    entities << entity
  end

  def entities
    @entities ||= []
  end

  attr_reader :identifier

  attr_writer :monograph

  attr_reader :monograph

  attr_reader :scanned_pages

  attr_reader :ocr

  attr_reader :metadata
end
