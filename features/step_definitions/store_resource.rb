class Package
  def entities
    []
  end
end

class Inbox
  def push(package)
  end
end

class Storage
  def has_entities(entities)
    false
  end
end

module WorldProperties
  def package
    @package ||= Package.new
  end

  def inbox
    @inbox ||= Inbox.new
  end

  def storage
    @storage ||= Storage.new
  end
end

World(WorldProperties)

Given("a package containing the scanned pages, OCR, and metadata") do
  package
end

When("the Collection Manager places the packaged resource in the incoming location") do
  inbox.push(package)
end

Then("the Collection Manager can see that it was preserved.") do
  expect(storage.has_entities(package.entities)).to be true
end
