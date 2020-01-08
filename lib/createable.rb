module Createable

  def game_hash_from_array_by_attribute(array, attribute)
    array.reduce({}) do |hash_acc, array_object|
      if hash_acc[array_object.send(attribute)]
        hash_acc[array_object.send(attribute)] << array_object
        hash_acc
      else
        hash_acc[array_object.send(attribute)] = [array_object]
			  hash_acc
      end
		end
  end

  def game_hash_from_hash_by_attribute(hash, key, attribute)
    hash[key].reduce({}) do |hash_acc, array_object|
      if hash_acc[array_object.send(attribute)]
        hash_acc[array_object.send(attribute)] << array_object
        hash_acc
      else
        hash_acc[array_object.send(attribute)] = [array_object]
			  hash_acc
      end
		end
  end

end
