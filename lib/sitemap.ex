defmodule Sitemap do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    children = [
      %{id: Sitemap.Config, start: {Sitemap.Config, :start_link, []}, restart: :transient},
      %{id: Sitemap.Builders.File, start: {Sitemap.Builders.File, :start_link, []}},
      %{id: Sitemap.Builders.Indexfile, start: {Sitemap.Builders.Indexfile, :start_link, []}},
      %{id: :namer_indexfile, start: {Sitemap.Namer, :start_link, [:indexfile]}},
      %{id: :namer_file, start: {Sitemap.Namer, :start_link, [:file, [zero: 1, start: 2]]}}
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_all, name: Sitemap.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc false
  defmacro __using__(opts) do
    quote do
      use Sitemap.DSL, unquote(opts)
    end
  end
end
