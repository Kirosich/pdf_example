defmodule Mix.Tasks.Gettext.Extract do
  use Mix.Task

  @shortdoc "Extract gettext translations"
  def run(_) do
    Mix.shell().cmd("mix gettext.extract")
  end
end
