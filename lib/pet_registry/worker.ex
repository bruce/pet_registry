defmodule PetRegistry.Worker do
  use GenServer

  def start_link(state, registry_name) do
    GenServer.start_link(__MODULE__, state, name: registry_name)
  end

  # Callbacks

  def handle_cast({:remove, name}, state) do
    {:noreply, Map.delete(state, name)}
  end

  def handle_cast({:add, name, value}, state) do
    {:noreply, Map.put(state, name, value)}
  end

  def handle_call(:list, _from, state) do
    {:reply, Map.keys(state), state}
  end

end
