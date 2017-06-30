defmodule Tleaog.Cache do
  use GenServer
  @name Cache

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def write(key, value) do
    GenServer.cast(@name, {:write, key, value})
  end

  def delete(key) do
    GenServer.cast(@name, {:delete, key})
  end

  def clear() do
    GenServer.cast(@name, :clear)
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def exists?(key) do
    GenServer.call(@name, {:exists, key})
  end

  def handle_cast(:clear, _cache) do
    {:noreply, %{}}
  end

  def handle_cast({:delete, key}, cache) do
    {:noreply, Map.delete(cache, key)}
  end

  def handle_cast({:write, key, value}, cache) do
    {:noreply, Map.put(cache, key, value)}
  end

  def handle_call({:read, key}, _from, cache) do
    {:reply, Map.get(cache, key, nil), cache}
  end

  def handle_call({:exists, key}, _from, cache) do
    {:reply, Map.has_key?(cache, key), cache}
  end
end
