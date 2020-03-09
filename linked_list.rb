# frozen_string_literal: true

# Represents the full linked list
class LinkedList
  attr_accessor :head

  # Adds a new node containing value to the end of the list and returns it
  def append(value)
    if @head
      tail.next_node = Node.new(value)
    else
      @head = Node.new(value)
    end
  end

  # Adds a new node containing value to the start of the list and returns it
  def prepend(value)
    if @head
      new_node = Node.new(value)
      new_node.next_node = @head
      @head = new_node
    else
      append(value)
    end
  end

  # Returns the total number of nodes in the list
  def size
    cur = @head
    counter = 0
    until cur.nil?
      counter += 1
      cur = cur.next_node
    end
    counter
  end

  # Returns the last node in the list
  def tail
    return nil if @head.nil?

    cur = @head
    cur = cur.next_node until cur.next_node.nil?
    cur
  end

  # Returns the node at the given index
  def at(index)
    cur = @head
    index.times { cur = cur.next_node }
    return cur unless cur.nil?
  end

  # Removes the last element from the list and returns it
  def pop
    remove_at(size - 1)
  end

  # Returns true if the passed in value is in the list
  # and otherwise returns false.
  def contains?(value)
    cur = @head
    until cur.nil?
      return true if cur.value == value

      cur = cur.next_node
    end
    false
  end

  # Returns the index of the node containing value, or nil if not found.
  def find(value)
    cur = @head
    cur_index = 0
    until cur.nil?
      return cur_index if value == cur.value

      cur = cur.next_node
      cur_index += 1
    end
    nil
  end

  # Represent the LinkedList objects as strings.
  def to_s
    return '' if @head.nil?

    cur = @head
    result = []
    until cur.nil?
      result << "( #{cur.value} ) ->"
      cur = cur.next_node
    end
    result << 'nil'
    result.join(' ')
  end

  # Inserts the node with the provided value at the given index and returns it
  def insert_at(value, index)
    if index.zero?
      prepend(value)
    elsif index > size || index.negative?
      nil
    else
      prev = nil
      cur = @head
      index.times do
        prev = cur
        cur = cur.next_node
      end
      new_node = Node.new(value)
      new_node.next_node = cur
      prev.next_node = new_node
    end
  end

  # Removes the node at the given index and returns the removed node
  def remove_at(index)
    prev = nil
    cur = @head
    if @head.nil? || index >= size || index.negative?
      nil
    elsif index.zero?
      @head = @head.next_node
      cur
    else
      index.times do
        prev = cur
        cur = cur.next_node
      end
      removed_node = prev.next_node
      prev.next_node = cur.next_node
      removed_node
    end
  end
end

# Represents the node
class Node
  attr_accessor :next_node
  attr_reader :value

  def initialize(value)
    @value = value
    @next_node = nil
  end
end
