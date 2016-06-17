defmodule PetRegistry do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(PetRegistry.Worker, [%{}, :registry_a], id: :worker1),
      worker(PetRegistry.Worker, [%{}, :registry_b], id: :worker2),
      worker(PetRegistry.Worker, [%{}, :registry_c], id: :worker3)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PetRegistry.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def remove(registry, name) do
    GenServer.cast(registry, {:remove, name})
  end

  def add(registry, name, value) do
    GenServer.cast(registry, {:add, name, value})
  end

  def list(registry) do
    GenServer.call(registry, :list)
  end

end
