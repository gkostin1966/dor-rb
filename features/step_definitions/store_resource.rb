require "./dor/identifier"
require "./dor/entity"
require "./dor/package"
require "./dor/inbox"
require "./dor/storage"
require "./dor/ingest"
require "./dor/workspace"

module WorldProperties
  def package
    @package ||= Package.new(Identifier.new("Hello"))
  end

  def inbox
    @inbox ||= Inbox.new
  end

  def storage
    @storage ||= Storage.new
  end

  def ingest
    @ingest ||= Ingest.new(inbox, workspace, storage)
  end

  def workspace
    @workspace ||= Workspace.new
  end
end

# World(WorldProperties)

Given("an incoming location containing packaged resources") do
  (0..4).each do |i|
    id = Identifier.new(i.to_s)
    e = Entity.new(id)
    p = Package.new(id)
    p.add_entity(e)
    inbox.add_package(p)
  end
end

Given("a package containing the scanned pages, OCR, and metadata in the incoming location") do
  package.add_entity(Entity.new(Identifier.new("a")))
  inbox.add_package(package)
end

When("the Collection Manager triggers the package for ingest") do
  ingest.process_package(package.identifier)
end

Then("the Collection Manager can see that it was preserved.") do
  expect(storage.has_entities?(package.entities)).to be true
end
