defmodule Railwayphoenix.CreditsLive do
  # In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use Phoenix.LiveView
  require Ecto.Query
  alias Railwayphoenix.{Repo, Empire}

  def render(assigns) do
    ~H"""
    <%= for empire <- @empires do %>
      <%= empire.name %>: <%= empire.credits %>
    <% end %>
    """
  end

  def mount(_params, _, socket) do
    Process.send_after(self(), :sync_data, 1000)

    {:ok, assign(socket, :empires, Repo.all(Empire))}
  end

  def handle_info(:sync_data, socket) do
    Process.send_after(self(), :sync_data, 1000)

    {:noreply, assign(socket, :empires, Repo.all(Empire))}
  end
end