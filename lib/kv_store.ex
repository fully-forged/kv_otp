defmodule KvStore do
  use GenServer

  ### Public api

  def set(store, key, value) do
    GenServer.cast(store, {:set, key, value})
  end

  def get(store, key) do
    GenServer.call(store, {:get, key})
  end

  def delete(store, key) do
    GenServer.cast(store, {:delete, key})
  end

  ## Callbacks

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    {:ok, %{}}
  end

  def handle_cast({:set, key, value}, state) do
    new_state = Map.put(state, key, value)
    {:noreply, new_state}
  end

  def handle_cast({:delete, key}, state) do
    new_state = Map.delete(state, key)
    {:noreply, new_state}
  end

  def handle_call({:get, key}, _from, state) do
    value = Map.get(state, key)
    {:reply, value, state}
  end
end