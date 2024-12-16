require "./dor/identifier"
require "./dor/monograph"
require "./dor/package"
require "./dor/preservation"
require "./dor/directive"
require "./dor/bin"
require "./dor/scanned_page"
require "./dor/ocr"
require "./dor/metadata"

module FulfillProperties
  def package
    return @package if @package
    @package = Package.new(Identifier.new)
    @package.add(monograph)
    @package.add(ScannedPage.new(monograph: monograph))
    @package.add(OCR.new(monograph: monograph))
    @package.add(Metadata.new(monograph: monograph))
    @package
  end

  def preservation
    @preservation ||= Preservation.new
  end

  def monograph
    @monograph ||= Monograph.new(Identifier.new)
  end

  def directive
    @directive ||= Directive.new(preservation)
  end
end

World(FulfillProperties)

Given("a package containing the scanned pages, OCR, and metadata of a monograph") do
  package
end

When("I submit the package for preservation") do
  directive.submit_package_for_preservation(package)
end

Then("I can see that the scanned pages, OCR, and metadata was preserved as a monograph.") do
  puts "ENTRIES: #{preservation.entries.keys}"
  puts "ENTITIES #{package.entities.map { |entry| entry.identifier.to_s }}"

  entries = preservation.entries.keys
  entities = package.entities.map { |entry| entry.identifier.to_s }
  expect(entries).to eql entities
end
