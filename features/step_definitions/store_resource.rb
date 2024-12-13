require "./dor/identifier"
require "./dor/entity"
require "./dor/package"
require "./dor/inbox"
require "./dor/storage"
require "./dor/ingest"

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
