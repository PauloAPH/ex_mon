defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attackOpponent(:computer, move)
      :computer -> Attack.attackOpponent(:player, move)
      end
  end

  def cure() do
    case Game.turn() do
      :player -> Heal.healLife(:player)
      :computer -> Heal.healLife(:computer)
      end
  end


  def fetchMove(move) do
    Game.player()
    |> Map.get(:moves)
    |> findMove(move)
  end

  defp findMove(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end
end
