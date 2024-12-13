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
