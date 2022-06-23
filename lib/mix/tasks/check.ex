defmodule Mix.Tasks.Check do
  @moduledoc """
  Mix task to check our app is good to deploy.
  """
  use Mix.Task

  @shortdoc "Checks our app is ready to deploy"
  @impl Mix.Task
  def run(_) do
    Mix.Task.run("compile")
    Mix.Task.run("credo")
    Mix.Task.run("test")
    Mix.Task.run("dialyzer")
  end
end
