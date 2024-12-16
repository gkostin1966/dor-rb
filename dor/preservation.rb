require "./dor/catalog"
require "./dor/store"
require "./dor/index"

class Preservation
  def initialize
    @catalog = Catalog.new
    @store = Store.new
    @index = Index.new
    @bins = []
  end

  def bin_for(monograph)
    bin = nil
    bins.each do |b|
      b.monograph == monograph
      bin = b
      break
    end
    return bin if bin

    bin = Bin.new(monograph)
    bins << bin
    bin
  end

  def has?(monograph)
    flag = false
    bins.each do |b|
      flag = b.monograph == monograph
      break if flag
    end
    flag
  end

  def identifiers
    @catalog.keys.map { |k| Identifier.new(k) }
  end

  attr_reader :bins

  def monograph_bin(monograph)
    bin = nil
    bins.each do |b|
      b.monograph == monograph
      bin = b
      break
    end
    bin
  end

  def preserve(package)
    package.entities.each do |entity|
      catalog.update(entity)
      store.update(entity)
      index.update(entity)
    end
  end

  attr_reader :catalog

  attr_reader :store

  attr_reader :index

  def entries
    catalog.entries
  end
end
