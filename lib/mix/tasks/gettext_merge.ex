defmodule Mix.Tasks.Gettext.Merge do
  use Mix.Task

  @shortdoc "Merges gettext translations"
  def run(_) do
    Mix.shell().cmd("mix gettext.merge priv/gettext")
  end
end
