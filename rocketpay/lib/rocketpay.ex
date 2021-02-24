defmodule Rocketpay do
  alias Rocketpay.User.Create, as: UserCreate
  alias Rocketpay.Accounts.Deposit
  # alias Rocketpay.Accounts.Withdraw

  defdelegate deposit(params), to: Deposit, as: :call
  # defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate create_user(params), to: UserCreate, as: :call
end
