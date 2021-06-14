defmodule Simple.Poll do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def add(participent) do
    Agent.update(__MODULE__, fn(state) ->
      Map.put(state, participent, 0)
    end)
  end

  def reset do
    Agent.update(__MODULE__, fn(_state) -> %{} end)
  end

  def reveal(participent) do
    Agent.get(__MODULE__, fn(state) ->
      Map.get(state, participent)
    end)
  end

  def all do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def vote(participent) do
    Agent.update(__MODULE__, fn(state) ->
      count = Map.get(state, participent)
      Map.replace(state, participent, count + 1)
    end)
  end
end
