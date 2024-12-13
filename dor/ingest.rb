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
