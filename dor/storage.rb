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
