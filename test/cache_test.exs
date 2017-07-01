defmodule CacheTest do
  use ExUnit.Case
  alias Tleaog.Cache

  @stooges ["Lary", "Curly", "Moe"]

  setup do
    Cache.start_link
    Cache.write(:stooges, @stooges)

    :ok
  end

  test "can store any valid Elixir term, given a key" do
    assert Cache.read(:stooges) == @stooges
  end

  test "updates when key already exists" do
    Cache.write(:stooges, :new)
    assert Cache.read(:stooges) == :new
  end

  test "can delete" do
    Cache.delete(:stooges)
    assert Cache.read(:stooges) == nil
  end

  test "can clear" do
    Cache.clear()
    assert Cache.read(:stooges) == nil
  end

  test "can check if exists" do
    assert Cache.exists?(:stooges) == true
  end
end
