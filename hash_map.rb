class HashMap
  def initialize(bucket_size = 16)
    @buckets = Array.new(bucket_size) { [] }
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    index = get_index(key)
    bucket = @buckets[index]

    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    bucket << [key, value]
    @size += 1
  end

  def get(key)
    index = get_index(key)
    bucket = @buckets[index]

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end

    nil
  end

  def has?(key)
    index = get_index(key)
    bucket = @buckets[index]

    bucket.each do |pair|
      return true if pair[0] == key
    end

    false
  end

  def remove(key)
    index = get_index(key)
    bucket = @buckets[index]

    bucket.each_with_index do |pair, i|
      next unless pair[0] == key

      bucket.delete_at(i)
      @size -= 1
      return pair[1]
    end

    nil
  end

  def length
    @size
  end

  def clear
    @buckets.each(&:clear)
    @size = 0
  end

  def keys
    result = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        result << pair[0]
      end
    end
    result
  end

  def values
    result = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        result << pair[1]
      end
    end
    result
  end

  def entries
    result = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        result << pair
      end
    end
    result
  end

  private

  def get_index(key)
    hash_code = hash(key)
    index = hash_code % @buckets.length
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end
end

class HashSet
  def initialize(bucket_size = 16)
    @hash_map = HashMap.new(bucket_size)
  end

  def add(key)
    @hash_map.set(key, true)
  end

  def remove(key)
    @hash_map.remove(key)
  end

  def contains?(key)
    @hash_map.has?(key)
  end

  def length
    @hash_map.length
  end

  def clear
    @hash_map.clear
  end

  def keys
    @hash_map.keys
  end
end
