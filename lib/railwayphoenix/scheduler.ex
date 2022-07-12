defmodule Railwayphoenix.Scheduler do
  use GenServer
  alias Railwayphoenix.{Repo, User, Empire}
  require Ecto.Query

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    Ecto.Query.from(Empire)
    |> Repo.all
    |> Kernel.then (fn (empires) -> Enum.map(empires, fn empire -> collect_revenue(empire) end) end)
    # Do the work you desire here
    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 60 * 60 * 1000) # In 1 hour
  end

  defp collect_revenue(empire) do
    Empire.changeset(empire, %{credits: empire.credits + 1})
      |> Repo.update
      |> Kernel.then (fn (res) -> log_new_revenue(res) end)
  end

  defp log_new_revenue(res) do
    case res do 
      {:ok, empire} ->
        IO.puts (empire.name <> " now has " <> to_string(empire.credits) <> " credits.")
      _ ->
        IO.puts "Something went wrong"
    end
  end
end