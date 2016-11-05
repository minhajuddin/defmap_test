defmodule DefmapTestTest do
  use ExUnit.Case

  test "defmap" do

    statuses = List.duplicate([417, 500, 205, 410, 404, 303, 503, 305, 307, 202, 501, 502, 409, 302, 416, 400,
           408, 300, 304, 201, 204, 412, 402, 406, 101, 200, 203, 414, 403, 100, 301, 413,
          206, 407, 401, 405, 411, 505, 504, 415], 100) |> List.flatten |> Enum.shuffle

    IO.puts("LOOKUPS PER RUN: #{length(statuses)}.")

    defmap_lookup = fn status -> HttpStatusMessage.get(status) end

    Benchee.run(%{time: 5}, %{
                  "defmap" => (fn -> statuses |> Enum.map(defmap_lookup) end),
                  "plainmap" => (fn -> statuses |> Enum.map(defmap_lookup) end),
                })
  end
end
