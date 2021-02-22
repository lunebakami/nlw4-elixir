defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_file/1" do
    test "when there is a file whit the given name, it returns the sum of numbers" do
      response = Numbers.sum_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there is no file whit the given name, it returns an error" do
      response = Numbers.sum_file("numberss")

      expected_response = {:error, %{message: "Invalid file!"}}

      assert response == expected_response
    end
  end
end
