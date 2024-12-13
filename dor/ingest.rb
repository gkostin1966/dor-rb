class Ingest
  def initialize(inbox, workspace, storage)
    @inbox = inbox
    @workspace = workspace
    @storage = storage
  end

  def process_package(identifier)
    package = inbox.find(identifier)

    workspace.add_package(package)

    package = workspace.find(identifier)

    package.entities.each do |entity|
      storage.add_entity(entity)
    end
  end

  attr_reader :inbox

  attr_reader :workspace

  attr_reader :storage
end
