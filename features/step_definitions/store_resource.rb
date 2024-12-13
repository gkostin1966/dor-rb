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

class Inbox
  def add_package(package)
    packages << package
  end

  def packages
    @packages ||= []
  end

  def find(identifier)
    package = nil
    packages.each do |p|
      next unless p.identifier == identifier
      package = p
      break
    end
    package
  end
end

class Storage
  def add_entity(entity)
    entities << entity
  end

  def has_entity?(e)
    entities.include? e
  end

  def has_entities?(e)
    flag = true
    e.each do |ee|
      next if has_entity? ee
      flag = false
      break
    end
    flag
  end

  def entities
    @entities ||= []
  end
end

class Ingest
  def initialize(inbox, storage)
    @inbox = inbox
    @storage = storage
  end

  def process_package(identifier)
    package = inbox.find(identifier)
    package.entities.each do |entity|
      storage.add_entity(entity)
    end
  end

  attr_reader :inbox

  attr_reader :storage
end

module WorldProperties
  def package
    @package ||= Package.new(Identifier.new("Greg"))
  end

  def inbox
    @inbox ||= Inbox.new
  end

  def storage
    @storage ||= Storage.new
  end

  def ingest
    @ingest ||= Ingest.new(inbox, storage)
  end
end

World(WorldProperties)

Given("a package containing the scanned pages, OCR, and metadata") do
  (0..4).each do |i|
    id = Identifier.new(i.to_s)
    e = Entity.new(id)
    p = Package.new(id)
    p.add_entity(e)
    inbox.add_package(p)
  end
  package.add_entity(Entity.new(Identifier.new("a")))
end

When("the Collection Manager places the packaged resource in the incoming location") do
  inbox.add_package(package)
  ingest.process_package(package.identifier)
end

Then("the Collection Manager can see that it was preserved.") do
  expect(storage.has_entities?(package.entities)).to be true
end
