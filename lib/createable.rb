module Createable

  def game_hash_from_array_by_attribute(array, attribute)
    array.reduce({}) do |hash, array_object|
      hash[array_object.send(attribute)] = [array_object] if hash[array_object.send(attribute)].nil?
      hash[array_object.send(attribute)] << array_object if hash[array_object.send(attribute)]
			hash
		end
  end

  def game_hash_from_hash_by_attribute(hash, key, attribute)
    hash[key].reduce({}) do |hash, array_object|
      hash[array_object.send(attribute)] = [array_object] if hash[array_object.send(attribute)].nil?
      hash[array_object.send(attribute)] << array_object if hash[array_object.send(attribute)]
			hash
		end
  end

end
