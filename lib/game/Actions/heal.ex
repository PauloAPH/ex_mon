defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @healPower 18..25

  def healLife(player) do
    player
    |> Game.fetchPlayer()
    |> Map.get(:life)
    |> calculateTotalLife()
    |> setLife(player)
  end

  defp calculateTotalLife(life), do: Enum.random(@healPower) + life

  defp setLife(life, player) when life > 100, do: updatePlayerLife(player, 100)
  defp setLife(life, player), do: updatePlayerLife(player, life)

  defp updatePlayerLife(player, life) do
    player
    |> Game.fetchPlayer()
    |> Map.put(:life, life)
    |> updateGame(player, life)
  end


  defp updateGame(playerData, player, life) do
    Game.info()
    |> Map.put(player, playerData)
    |> Game.update()

    Status.printMoveMsg(player, :heal, life)
  end
end
