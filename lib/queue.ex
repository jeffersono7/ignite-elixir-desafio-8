defmodule Queue do
  use GenServer

  # Client
  def start_link(initial_queue) do
    GenServer.start_link(__MODULE__, initial_queue, name: __MODULE__)
  end

  def enqueue(pid_or_module \\ __MODULE__, element) do
    GenServer.cast(pid_or_module, {:enqueue, element})
  end

  def dequeue(pid_or_module \\ __MODULE__) do
    GenServer.call(pid_or_module, :dequeue)
  end

  # Server
  def init(state), do: {:ok, state}

  def handle_cast({:enqueue, element}, state) do
    {:noreply, state ++ [element]}
  end

  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:dequeue, _from, [head | tail]) do
    {:reply, head, tail}
  end
end
