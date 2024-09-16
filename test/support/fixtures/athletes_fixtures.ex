defmodule Beepboop.AthletesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Beepboop.Athletes` context.
  """

  @doc """
  Generate a athlete.
  """
  def athlete_fixture(attrs \\ %{}) do
    {:ok, athlete} =
      attrs
      |> Enum.into(%{
        emoji: "some emoji",
        name: "some name",
        sport: "some sport",
        status: :training
      })
      |> Beepboop.Athletes.create_athlete()

    athlete
  end
end
