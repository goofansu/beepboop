defmodule Beepboop.AthletesTest do
  use Beepboop.DataCase

  alias Beepboop.Athletes

  describe "athletes" do
    alias Beepboop.Athletes.Athlete

    import Beepboop.AthletesFixtures

    @invalid_attrs %{name: nil, status: nil, emoji: nil, sport: nil}

    test "list_athletes/0 returns all athletes" do
      athlete = athlete_fixture()
      assert Athletes.list_athletes() == [athlete]
    end

    test "get_athlete!/1 returns the athlete with given id" do
      athlete = athlete_fixture()
      assert Athletes.get_athlete!(athlete.id) == athlete
    end

    test "create_athlete/1 with valid data creates a athlete" do
      valid_attrs = %{name: "some name", status: :training, emoji: "some emoji", sport: "some sport"}

      assert {:ok, %Athlete{} = athlete} = Athletes.create_athlete(valid_attrs)
      assert athlete.name == "some name"
      assert athlete.status == :training
      assert athlete.emoji == "some emoji"
      assert athlete.sport == "some sport"
    end

    test "create_athlete/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Athletes.create_athlete(@invalid_attrs)
    end

    test "update_athlete/2 with valid data updates the athlete" do
      athlete = athlete_fixture()
      update_attrs = %{name: "some updated name", status: :competing, emoji: "some updated emoji", sport: "some updated sport"}

      assert {:ok, %Athlete{} = athlete} = Athletes.update_athlete(athlete, update_attrs)
      assert athlete.name == "some updated name"
      assert athlete.status == :competing
      assert athlete.emoji == "some updated emoji"
      assert athlete.sport == "some updated sport"
    end

    test "update_athlete/2 with invalid data returns error changeset" do
      athlete = athlete_fixture()
      assert {:error, %Ecto.Changeset{}} = Athletes.update_athlete(athlete, @invalid_attrs)
      assert athlete == Athletes.get_athlete!(athlete.id)
    end

    test "delete_athlete/1 deletes the athlete" do
      athlete = athlete_fixture()
      assert {:ok, %Athlete{}} = Athletes.delete_athlete(athlete)
      assert_raise Ecto.NoResultsError, fn -> Athletes.get_athlete!(athlete.id) end
    end

    test "change_athlete/1 returns a athlete changeset" do
      athlete = athlete_fixture()
      assert %Ecto.Changeset{} = Athletes.change_athlete(athlete)
    end
  end
end
